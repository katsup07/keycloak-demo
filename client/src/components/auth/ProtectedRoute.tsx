import { Navigate } from 'react-router-dom'
import { useAuthStore } from '../../stores/authStore'

type Props = {
  children: React.ReactNode;
  requiredRole?: string | null;
}

export const ProtectedRoute = ({ children, requiredRole = null }: Props) => {
  const { isAuthenticated, hasRole, isLoading } = useAuthStore()

  

  if (isLoading)
    return <Loading />;

  // 認証されていない場合はkeycloak-jsがリダイレクトを処理する
  if (!isAuthenticated)
    return <Loading />;
  

  if (requiredRole && !hasRole(requiredRole))
    return <Navigate to="/unauthorized" replace />


  return children
}

const Loading = () => (
  <div className="flex justify-center items-center min-h-64">
    <div className="text-lg text-gray-600">Loading...</div>
  </div>
);