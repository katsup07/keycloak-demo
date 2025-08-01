import React from 'react';
import * as keycloakService from '../../services/keycloakService';

type Props = {
  showEmptyState?: boolean;
};

export const RoleDisplay: React.FC<Props> = ({ 
  showEmptyState = true 
}) => {
  const realmRoles = keycloakService.getRealmRoles();
  const clientRoles = keycloakService.getClientApplicationRoles();

  return (
    <div className="text-gray-300">
      <span className="font-medium">Roles:</span>
      
      {/* Role Legend */}
      <div className="flex gap-4 mt-2 mb-3 text-sm">
        <div className="flex items-center gap-1">
          <div className="w-4 h-4 bg-blue-300 rounded"></div>
          <span>Realm Roles</span>
        </div>
        <div className="flex items-center gap-1">
          <div className="w-4 h-4 bg-orange-300 rounded"></div>
          <span>Client Roles</span>
        </div>
      </div>

      {/* Realm Roles */}
      <div className="mb-2">
        <span className="text-sm font-medium text-gray-400">Realm:</span>
        <div className="flex flex-wrap gap-1 mt-1">
          {realmRoles.length > 0 ? (
            realmRoles.map((role, idx) => (
              <span
                key={`realm-${idx}`}
                className="bg-blue-300 text-white px-3 py-1 text-sm rounded"
              >
                {role}
              </span>
            ))
          ) : showEmptyState ? (
            <span className="text-gray-400 text-sm italic">No realm roles</span>
          ) : null}
        </div>
      </div>

      {/* Client Roles */}
      <div>
        <span className="text-sm font-medium text-gray-400">Client:</span>
        <div className="flex flex-wrap gap-1 mt-1">
          {clientRoles.length > 0 ? (
            clientRoles.map((role, idx) => (
              <span
                key={`client-${idx}`}
                className="bg-orange-300 text-white px-3 py-1 text-sm rounded"
              >
                {role}
              </span>
            ))
          ) : showEmptyState ? (
            <span className="text-gray-400 text-sm italic">No client roles</span>
          ) : null}
        </div>
      </div>
    </div>
  );
};
