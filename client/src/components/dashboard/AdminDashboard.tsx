import { useState, useEffect } from 'react'
import { getAdminData } from '../../services/apiService'
import { useAuthStore } from '../../stores/authStore'
import { DashboardHeader } from './DashboardHeader'
import { ErrorBanner } from './ErrorBanner'
import { UserProfileInfo } from './UserProfileInfo'


export const AdminDashboard = () => {
  const { user } = useAuthStore()
  const [adminData, setAdminData] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [testLoading, setTestLoading] = useState(false)

  const fetchAdminData = async () => {
    try {
      setLoading(true)
      setError(null)
      const data = await getAdminData()
      setAdminData(data)
    } catch (err) {
      console.error('Failed to fetch admin data:', err)
      setError('Failed to load admin data. This is expected if the backend server is not running.')
    } finally {
      setLoading(false)
    }
  }

  const testApiCall = async () => {
    try {
      setTestLoading(true)
      await fetchAdminData()
    } finally {
      setTestLoading(false)
    }
  }

  useEffect(() => {
    fetchAdminData()
    setError(null)
  }, [])

  if (loading) {
    return (
      <div className="flex justify-center items-center min-h-64">
        <div className="text-lg text-gray-600">Loading admin data...</div>
      </div>
    )
  }

  return (
    <div className="max-w-6xl mx-auto">
      <DashboardHeader
        title="Admin Dashboard"
        loading={testLoading}
        onTest={testApiCall}
      />
      {error && <ErrorBanner message={error} />}
      <div className="grid md:grid-cols-2 gap-6">
        <UserProfileInfo user={user!} />
        <div className="bg-white rounded-lg shadow-md p-6">
          <h2 className="text-xl font-semibold text-gray-800 mb-4">Admin Data</h2>
          <pre className="bg-gray-50 p-4 rounded text-sm overflow-auto max-h-64">
            {JSON.stringify(adminData, null, 2)}
          </pre>
        </div>
      </div>
    </div>
  )
}