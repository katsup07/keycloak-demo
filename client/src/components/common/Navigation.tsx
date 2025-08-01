import { Link } from 'react-router-dom'
import { useAuthStore } from '../../stores/authStore'
import { RoleBasedLink } from './RoleBasedLink'

export const Navigation = () => {
  const { isAuthenticated, user, logout } = useAuthStore()

  const linkClassName = "text-gray-900 hover:text-blue-600 px-3 py-2 rounded-md text-sm font-medium transition-colors"

  return (
    <nav className="bg-white shadow-sm border-b border-gray-200">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between items-center h-16">
          <div className="flex space-x-8">
            <Link 
              to="/" 
              className={linkClassName}
            >
              Home
            </Link>
            <RoleBasedLink 
              to="/user" 
              requiredRole="user" 
              className={linkClassName}
            >
              User Dashboard
            </RoleBasedLink>
            <RoleBasedLink 
              to="/admin" 
              requiredRole="admin" 
              className={linkClassName}
            >
              Admin Dashboard
            </RoleBasedLink>
          </div>
          <div className="flex items-center space-x-4">
            {isAuthenticated && (
              <>
                <span className="text-gray-700 text-sm">
                  Welcome, {user?.username || user?.firstName || 'User'}
                </span>
                <button 
                  onClick={logout}
                  className="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-md text-sm font-medium transition-colors cursor-pointer"
                >
                  Logout
                </button>
              </>
            ) }
          </div>
        </div>
      </div>
    </nav>
  )
}
