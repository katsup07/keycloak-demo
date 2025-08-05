import { useState, useEffect } from 'react'
import { getUserData, getUserProfile } from '../../services/apiService'
import { useAuthStore } from '../../stores/authStore'
import { UserProfileInfo } from './UserProfileInfo'
import { UserApiData } from './UserApiData'
import { DashboardHeader } from './DashboardHeader'
import { ErrorBanner } from './ErrorBanner'

export const UserDashboard = () => {
  const { user } = useAuthStore()
  const [userData, setUserData] = useState(null)
  const [userProfile, setUserProfile] = useState(null)
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [testLoading, setTestLoading] = useState(false)

  const fetchData = async () => {
    try {
      setLoading(true)
      setError(null)
      
      // 複数API呼出(トークン更新テスト)
      const [dataResponse, profileResponse] = await Promise.allSettled([
        getUserData(),
        getUserProfile()
      ])
      
      if (dataResponse.status === 'fulfilled') {
        setUserData(dataResponse.value)
      } else {
        console.error('Failed to fetch user data:', dataResponse.reason)
      }
      
      if (profileResponse.status === 'fulfilled') {
        setUserProfile(profileResponse.value)
      } else {
        console.error('Failed to fetch user profile:', profileResponse.reason)
      }
      
    } catch (error) {
      console.error('Failed to fetch user data:', error)
      setError('Failed to load user data. This is expected if the backend server is not running.')
    } finally {
      setLoading(false)
    }
  }

  const testApiCall = async () => {
    try {
      setTestLoading(true);
      await fetchData();
    } finally {
      setTestLoading(false);
    }
  }

  useEffect(() => {
    fetchData();
    setError(null);
  }, [])

  if (loading) {
    return (
      <div className="flex justify-center items-center min-h-64">
        <div className="text-lg text-gray-600">Loading user data...</div>
      </div>
    )
  }

  return (
    <div className="max-w-4xl mx-auto">
      <DashboardHeader
        title="User Dashboard"
        loading={testLoading}
        onTest={testApiCall}
      />
      {error && <ErrorBanner message={error} />}
      <div className="grid md:grid-cols-2 gap-6">
        <UserProfileInfo user={user!} />
        <UserApiData userData={userData} userProfile={userProfile} />
      </div>
    </div>
  )
}
