import { create } from 'zustand';
import * as keycloakService from '../services/keycloakService';

type User = {
  id?: string;
  username?: string;
  email?: string;
  firstName?: string;
  lastName?: string;
  roles: string[];
}

type AuthState = {
  user: User | null;
  isAuthenticated: boolean;
  roles: string[];
  isLoading: boolean;
  isAuthStoreInitialized: boolean;
  initializeAuth: () => Promise<void>;
  login: () => void;
  logout: () => void;
  hasRole: (role: string) => boolean;
  isAdmin: () => boolean;
  refreshUser: () => void;
}

// ストアの機能
// 1. Zustandを使用してReactアプリケーションの状態を管理する
// 2. ストアの定義: create関数を使って状態とアクションを指定する
// 3. Getter（get）: 現在の状態を取得するために使用する
// 4. Setter（set）: 状態を更新するために使用する
// Note: Keycloakで認証を処理し、Zustandでフロントエンドの状態を管理・同期
// https://zustand.docs.pmnd.rs/getting-started/introduction
export const useAuthStore = create<AuthState>((set, get) => ({
  // 状態
  user: null,
  isAuthenticated: false,
  roles: [],
  isLoading: true,
  isAuthStoreInitialized: false,

  // アクション
  initializeAuth: async () => {
    // 複数初期化防止
    if (get().isAuthStoreInitialized) {
      set({ isLoading: false });
      return;
    }

    try {
      set({ isLoading: true });
      const authenticated = await keycloakService.initializeKeycloak();

      if(!authenticated) {
        set({
          user: null,
          isAuthenticated: false,
          roles: [],
          isLoading: false,
          isAuthStoreInitialized: true
        });
        return;
      }
      
      // 初期化成功後にユーザとロール設定
        const userInfo = keycloakService.getUserInfo();
        const roles = [...keycloakService.getRealmRoles(), ...keycloakService.getClientApplicationRoles()];
        
        set({
          user: userInfo,
          isAuthenticated: true,
          roles,
          isLoading: false,
          isAuthStoreInitialized: true
        });
    } 
    catch (error) {
      console.error('Failed to initialize authentication:', error);
      set({
        user: null,
        isAuthenticated: false,
        roles: [],
        isLoading: false,
        isAuthStoreInitialized: true
      });
    }
  },

  login: () => {
    keycloakService.login();
  },

  logout: () => {
    keycloakService.logout();
    // 次回マウント/ログイン時に再初期化
    set({
      user: null,
      isAuthenticated: false,
      roles: [],
      isAuthStoreInitialized: false,
      isLoading: true,
    });
  },

  refreshUser: () => {
    if (keycloakService.isAuthenticated()) {
      const userInfo = keycloakService.getUserInfo();
      const roles = [...keycloakService.getRealmRoles(), ...keycloakService.getClientApplicationRoles()];
      
      set({
        user: userInfo,
        isAuthenticated: true,
        roles
      });
    }
  },

  hasRole: (role) => {
    return get().roles.includes(role);
  },

  isAdmin: () => {
    return get().roles.includes('admin') || keycloakService.isAdmin();
  }
}));
