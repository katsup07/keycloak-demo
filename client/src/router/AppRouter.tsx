import { createBrowserRouter, RouterProvider, Outlet } from 'react-router-dom';
import { ToastContainer } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';

import { Navigation } from '@/components/common/Navigation';
import { Home } from '@/components/Home';
import { AdminDashboard } from '@/components/dashboard/AdminDashboard';
import { UserDashboard } from '@/components/dashboard/UserDashboard';
import { UnauthorizedPage } from '@/components/common/UnauthorizedPage';
import { ProtectedRoute }from '@/components/auth/ProtectedRoute';

// 全ルート共通レイアウト
const Layout = () => (
  <div className="min-h-screen bg-black">
    <Navigation />
    <main className="p-8">
      <Outlet />
    </main>
    <ToastContainer position="top-right" />
  </div>
);

// ルート設定obj
const router = createBrowserRouter([
  {
    path: "/",
    element: <Layout />,
    children: [
      {
        index: true,
        element: <Home />
      },
      {
        path: "admin",
        element: (
          <ProtectedRoute requiredRole="admin">
            <AdminDashboard />
          </ProtectedRoute>
        )
      },
      {
        path: "user",
        element: (
          <ProtectedRoute requiredRole="user">
            <UserDashboard />
          </ProtectedRoute>
        )
      },
      {
        path: "unauthorized",
        element: <UnauthorizedPage />
      }
    ]
  }
]);

export const AppRouter = () => <RouterProvider router={router} />;