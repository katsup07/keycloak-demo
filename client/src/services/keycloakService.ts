/**
 * Keycloakサービスモジュール
 *
 * Keycloakで認証とトークン管理を実施
 *
 * 主なセキュリティ機能:
 * - PKCE: コード盗聴防止
 * - サイレントSSO: 明示ログインなしで確認
 * - iframeチェック: 定期セッション確認
 * - バックアップ更新: UX向上＆例外対応
 *
 * Notes:
 * - iframe経由で安全通信（OAuth2 PKCE/SHA-256）
 * - PKCE詳細: https://www.authlete.com/developers/pkce/
 * - インターセプタ＆バックアップで更新管理
 */

// 認証用Keycloakサービス
import Keycloak from 'keycloak-js';
import { setupTokenRefreshInterval } from './serviceUtils';
import { BACKGROUND_REFRESH_TOKEN_INTERVAL, TOKEN_MIN_VALIDITY } from './constants';



const keycloakConfig = {
  url: import.meta.env.VITE_KEYCLOAK_URL || 'http://localhost:8080',
  realm: import.meta.env.VITE_KEYCLOAK_REALM || 'keycloak-demo',
  clientId: import.meta.env.VITE_KEYCLOAK_CLIENT_ID || 'react-client',
};

// Keycloakインスタンス作成
let keycloak: Keycloak | null = null;

export const initializeKeycloak = async (): Promise<boolean> => {
  try {

    if (keycloak && keycloak.authenticated !== undefined) {
      console.log('Keycloak already initialized, returning current auth status');
      return keycloak.authenticated || false;
    }

    if (!keycloak)
      keycloak = new Keycloak(keycloakConfig);

    // iframe経由で安全通信
    const authenticated = await keycloak.init({
      onLoad: 'check-sso',
      silentCheckSsoRedirectUri: window.location.origin + '/silent-check-sso.html',
      checkLoginIframe: true,
      pkceMethod: 'S256', 
    });

    // バックアップ更新
    if (authenticated)
     setupTokenRefreshInterval(keycloak, BACKGROUND_REFRESH_TOKEN_INTERVAL, logout);

    return authenticated;
  } catch (error) {
    console.error('Failed to initialize Keycloak:', error);
    return false;
  }
};

export const login = () => {
  if (!keycloak)
    throw new Error('Keycloak not initialized');
  
  keycloak.login();
};

export const logout = () => {
  if (!keycloak)
    throw new Error('Keycloak not initialized');
  
  keycloak.logout();
};

export const getToken = (): string | undefined => {
  return keycloak?.token;
};

export const getRefreshToken = (): string | undefined => {
  return keycloak?.refreshToken;
};

export const getUserInfo = () => {
  if (!keycloak?.authenticated)
    return null;

  return {
    id: keycloak.tokenParsed?.sub,
    username: keycloak.tokenParsed?.preferred_username,
    email: keycloak.tokenParsed?.email,
    firstName: keycloak.tokenParsed?.given_name,
    lastName: keycloak.tokenParsed?.family_name,
    roles: getRealmRoles().concat(getClientApplicationRoles()),
    ...keycloak.tokenParsed
  };
};

export const hasRole = (role: string): boolean => {
  if (!keycloak?.authenticated)
    return false;

  const realmRoles = getRealmRoles();
  const resourceRoles = getClientApplicationRoles();
  
  return realmRoles.includes(role) || resourceRoles.includes(role);
};

export const hasRealmRole = (role: string): boolean => {
  return getRealmRoles().includes(role);
};

export const hasResourceRole = (role: string, resource?: string): boolean => {
  if (!keycloak?.tokenParsed?.resource_access) {
    return false;
  }

  const clientId = resource || keycloakConfig.clientId;
  const clientRoles = keycloak.tokenParsed.resource_access[clientId]?.roles || [];
  
  return clientRoles.includes(role);
};

/**
 * JWTトークンからレルムロールを取得する。
 * レルムロールはKeycloak全体で有効なグローバル権限。複数のクライアントで使う場合
 * @returns レルムロール名の配列
 */
export const getRealmRoles = (): string[] => {
  return keycloak?.tokenParsed?.realm_access?.roles || [];
};

/**
 * JWTトークンからクライアントロールを取得する。
 * クライアントロールは特定アプリ用の権限（例: user, adminなど）。
 * @returns 現在のクライアントのロール名配列
 */
export const getClientApplicationRoles = (): string[] => {
  if (!keycloak?.tokenParsed?.resource_access)
    return [];

  
  const clientRoles = keycloak.tokenParsed.resource_access[keycloakConfig.clientId];
  return clientRoles?.roles || [];
};

export const isAuthenticated = (): boolean => {
  return keycloak?.authenticated || false;
};

export const updateToken = (minValidity: number = TOKEN_MIN_VALIDITY): Promise<boolean> => {
  if (!keycloak)
    return Promise.resolve(false);
  
  return keycloak.updateToken(minValidity);
};

export const isAdmin = (): boolean => {
  return hasRole('admin') || hasRealmRole('admin');
};
