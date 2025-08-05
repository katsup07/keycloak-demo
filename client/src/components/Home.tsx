import { useAuthStore } from "@/stores/authStore";
import { RoleBasedLink } from './common/RoleBasedLink';
import { RoleDisplay } from './common/RoleDisplay';

export const Home = () => {
  const { isAuthenticated, login, user } = useAuthStore();

  if (isAuthenticated) {
    return (
      <div className="max-w-4xl mx-auto text-center py-16">
        <div className="bg-gray-900 rounded-xl shadow-lg p-8 mb-8">
          <h1 className="text-4xl font-bold text-white mb-4">
            Welcome back, {user?.firstName || user?.username || 'User'}!
          </h1>
          <p className="text-lg text-gray-400 mb-6">
            You are successfully authenticated with Keycloak.
          </p>
          
          {/* ユーザ情報 */}
          {user && (
            <div className="bg-gray-800 rounded-lg p-6 mb-6 text-left">
              <h3 className="text-xl font-semibold text-white mb-4">Your Profile</h3>
              <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                <div>
                  <p className="text-gray-400">Username:</p>
                  <p className="text-white font-medium">{user.username}</p>
                </div>
                <div>
                  <p className="text-gray-400">Email:</p>
                  <p className="text-white font-medium">{user.email}</p>
                </div>
                <div>
                  <p className="text-gray-400">First Name:</p>
                  <p className="text-white font-medium">{user.firstName || 'N/A'}</p>
                </div>
                <div>
                  <p className="text-gray-400">Last Name:</p>
                  <p className="text-white font-medium">{user.lastName || 'N/A'}</p>
                </div>
                <div className="md:col-span-2">
                  <RoleDisplay />
                </div>
              </div>
            </div>
          )}
          
          {/* ナビボタン */}
          <div className="flex justify-center space-x-4">
            <RoleBasedLink
            to="/user"
            requiredRole="user"
            className="bg-blue-600 hover:bg-blue-700 text-white px-6 py-3 rounded-lg transition-colors duration-200"
            >
              User Dashboard
            </RoleBasedLink>
            <RoleBasedLink
              to="/admin"
              requiredRole="admin"
              className="bg-green-600 hover:bg-green-700 text-white px-6 py-3 rounded-lg transition-colors duration-200"
            >
              Admin Dashboard
            </RoleBasedLink>
          </div>
        </div>
      </div>
    )
  }

  return (
    <div className="max-w-md mx-auto text-center py-16">
      <div className="bg-gray-900 rounded-xl shadow-lg p-8">
        <h1 className="text-4xl font-bold text-white mb-6">Keycloakデモ</h1>
        <p className="text-lg text-gray-400 mb-8">
          認証デモへようこそ。
        </p>
        
        <div className="space-y-6">
          <div className="bg-gray-800 rounded-lg p-4">
            <p className="text-sm text-gray-400 mb-2">このデモは</p>
            <ul className="text-sm text-gray-300 space-y-1">
              <li>• 認証にKeycloakを使用</li>
              <li>• ロールベースのアクセス制御</li>
              <li>• JWTトークン管理</li>
              <li>• 自動トークン更新</li>
            </ul>
          </div>
          
          <button
            type="button"
            onClick={login}
            className="w-full bg-blue-700 hover:bg-blue-800 text-white font-semibold py-3 px-6 rounded-lg transition-colors duration-200 shadow-lg cursor-pointer"
          >
            ログイン
          </button>
        </div>
        
        <p className="text-xs text-gray-600 mt-6">
          認証のためにKeycloakにリダイレクトされます。
        </p>
      </div>
    </div>
  )
}
