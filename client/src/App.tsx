import { useEffect} from 'react';
import { AppRouter } from './router/AppRouter';
import { useAuthStore } from './stores/authStore';

function App() {
  const { initializeAuth, isLoading, isAuthStoreInitialized } = useAuthStore();

  useEffect(() => {
    if (!isAuthStoreInitialized) 
      initializeAuth();
  }, [initializeAuth, isAuthStoreInitialized]);

  if (isLoading) {
    return (
      <div className="min-h-screen bg-black flex items-center justify-center">
        <div className="text-white text-xl">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-white mx-auto mb-4"></div>
          Initializing authentication...
        </div>
      </div>
    );
  }

  return <AppRouter />;
}

export default App;
