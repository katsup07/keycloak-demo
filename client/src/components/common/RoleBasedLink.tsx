import { Link } from 'react-router-dom';
import { useAuthStore } from '../../stores/authStore';

type Props = {
  to: string;
  requiredRole?: string;
  requireAuth?: boolean;
  className?: string;
  children: React.ReactNode;
};

export const RoleBasedLink: React.FC<Props> = ({ 
  to, 
  requiredRole, 
  requireAuth = true, 
  className, 
  children 
}) => {
  const { isAuthenticated, hasRole } = useAuthStore();

  if (requireAuth && !isAuthenticated)
    return null;

  if (requiredRole && !hasRole(requiredRole))
    return null;

  return (
    <Link to={to} className={className}>
      {children}
    </Link>
  );
};
