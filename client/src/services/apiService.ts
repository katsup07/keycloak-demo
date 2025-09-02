// バックエンド通信用APIサービス
import axios, { AxiosRequestConfig, AxiosResponse } from 'axios';
import * as keycloakService from './keycloakService';
import { getBearerHeader } from '@/utils/authUtils';
import { shouldRefreshToken, handleTokenRefresh } from './serviceUtils';

const apiClient = axios.create({
  // Prefer VITE_API_BASE_URL when explicitly set; otherwise use relative '/api' to leverage Vite proxy
  baseURL: import.meta.env.VITE_API_BASE_URL || '/api',
  headers: {
    'Content-Type': 'application/json',
  },
});

// 認証トークン付与ミドルウェア
apiClient.interceptors.request.use(
  async (config) => {
    const token = keycloakService.getToken();
    if (token)
      config.headers.Authorization = getBearerHeader();

    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// ミドルウェア - レスポンスインターセプターでトークンの有効期限をチェック
apiClient.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config;
    
    if (!shouldRefreshToken(error, originalRequest))
      return Promise.reject(error);
    
    return handleTokenRefresh(originalRequest, apiClient);
  }
);

// パブリックAPI呼び出し（認証不要）
export const getPublicInfo = async (): Promise<any> => {
  try {
    const response = await apiClient.get('/public/info');
    return response.data;
  } catch (error) {
    console.error('Failed to fetch public info:', error);
    throw error;
  }
};

// 管理者API呼び出し（admin権限）
export const getAdminData = async (): Promise<any> => {
  try {
    const response = await apiClient.get('/admin/data');
    return response.data;
  } catch (error) {
    console.error('Failed to fetch admin data:', error);
    throw error;
  }
};

export const getAdminUsers = async (): Promise<any> => {
  try {
    const response: AxiosResponse = await apiClient.get('/admin/users');
    return response.data;
  } catch (error) {
    console.error('Failed to fetch admin users:', error);
    throw error;
  }
};

// ユーザーAPI呼び出し（user/admin権限）
export const getUserData = async (): Promise<any> => {
  try {
    const response: AxiosResponse = await apiClient.get('/user/data');
    return response.data;
  } catch (error) {
    console.error('Failed to fetch user data:', error);
    throw error;
  }
};

export const logoutUserOnServer = async (): Promise<void> => {
  try {
    await apiClient.post('/user/logout');
  } catch (error) {
    console.warn('Failed to logout user:', error);
    throw error;
  }
};

export const getUserProfile = async (): Promise<any> => {
  try {
    const response: AxiosResponse = await apiClient.get('/user/profile');
    return response.data;
  } catch (error) {
    console.error('Failed to fetch user profile:', error);
    throw error;
  }
};

// 汎用APIヘルパー
export const apiCall = async <T>(config: AxiosRequestConfig): Promise<T> => {
  try {
    const response: AxiosResponse<T> = await apiClient(config);
    return response.data;
  } catch (error) {
    console.error('API call failed:', error);
    throw error;
  }
};
