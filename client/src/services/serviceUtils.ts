// APIサービス用トークン更新＆エラ処理ユーティリティ
import * as keycloakService from './keycloakService';
import { getBearerHeader } from '@/utils/authUtils';
import Keycloak from 'keycloak-js';
import { TOKEN_MIN_VALIDITY } from './constants';

// 複数の同時リフレッシュ試行を防ぐため
let refreshTokenResultPromise: Promise<boolean> | null = null;

// トークン更新処理
export const handleTokenRefresh = async (originalRequest: any, apiClient: any): Promise<any> => {
  originalRequest._retry = true;
  
  try {
    const isRefreshed = await refreshAuthToken();
    
    if (!isRefreshed)
      return handleAuthFailure('Token refresh failed');
    
    return retryRequestWithNewToken(originalRequest, apiClient);
  } catch (refreshError) {
    console.error('Token refresh failed:', refreshError);
    keycloakService.logout();
    return Promise.reject(refreshError);
  }
};

const refreshAuthToken = async (): Promise<boolean> => {
  if (!refreshTokenResultPromise) {
    console.log("Attempting to refresh token in interceptor...");
    refreshTokenResultPromise = keycloakService.updateToken(TOKEN_MIN_VALIDITY);
  }
  
  try {
    const isRefreshed = await refreshTokenResultPromise;
    refreshTokenResultPromise = null;
    return isRefreshed;
  } catch (error) {
    refreshTokenResultPromise = null;
    throw error;
  }
};

// 認証失敗処理
const handleAuthFailure = (message: string): Promise<never> => {
  console.log(message);
  keycloakService.logout();
  return Promise.reject(new Error('Authentication failed'));
};

// 新トークンでリクエスト再試行
const retryRequestWithNewToken = async (originalRequest: any, apiClient: any): Promise<any> => {
  const newToken = keycloakService.getToken();
  if (!newToken)
    return handleAuthFailure('Failed to get token after refresh');

  console.log("Refreshed token in interceptor");
  originalRequest.headers.Authorization = getBearerHeader();
  return apiClient(originalRequest);
};


// エラーがトークンリフレッシュをトリガーするかどうかを判定する
export const shouldRefreshToken = (error: any, originalRequest: any): boolean => {
  return error.response?.status === 401 && !originalRequest._retry;
};

export const setupTokenRefreshInterval = (keycloakInstance: Keycloak, timeInterval: number, onError: () => void) => {
  setInterval(() => {
    keycloakInstance.updateToken(TOKEN_MIN_VALIDITY).then((refreshed: boolean) => {
      if (refreshed) 
        console.log(`Token auto refreshed after ${timeInterval} ms`);
    }).catch(() => {
      console.log('Failed to refresh token');
      onError();
    });
  }, timeInterval);
};







