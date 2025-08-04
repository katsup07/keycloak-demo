// 認証用ユーティリティ
import * as keycloakService from '../services/keycloakService';

export const getBearerHeader = () => {
  const token = keycloakService.getToken();
  
  if (!token) return;

  return `Bearer ${token}`;
};