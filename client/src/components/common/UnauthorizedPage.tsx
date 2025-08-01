export const UnauthorizedPage = () => {
  return (
    <div className="max-w-md mx-auto text-center py-16">
      <div className="bg-red-50 rounded-lg p-8">
        <div className="text-6xl mb-4">🚫</div>
        <h1 className="text-3xl font-bold text-red-800 mb-4">403 - Unauthorized</h1>
        <p className="text-red-600 mb-2">You don't have permission to access this page.</p>
        <p className="text-red-600 text-sm">Please contact your administrator if you believe this is an error.</p>
      </div>
    </div>
  )
}
