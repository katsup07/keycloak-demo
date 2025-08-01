import React from 'react';
import { RoleDisplay } from '../common/RoleDisplay';

type Props = {
  user: {
    username?: string;
    email?: string;
    firstName?: string;
    lastName?: string;
    id?: string;
    roles?: string[];
  };
};

export const UserProfileInfo: React.FC<Props> = ({ user }) => (
  <div className="bg-white rounded-lg shadow-md p-6">
    <h2 className="text-xl font-semibold text-gray-800 mb-4">Profile Information</h2>
    <div className="space-y-2">
      <p className="text-gray-600">
        <span className="font-medium">Username:</span> {user.username}
      </p>
      <p className="text-gray-600">
        <span className="font-medium">Email:</span> {user.email}
      </p>
      <p className="text-gray-600">
        <span className="font-medium">First Name:</span> {user.firstName || 'Not provided'}
      </p>
      <p className="text-gray-600">
        <span className="font-medium">Last Name:</span> {user.lastName || 'Not provided'}
      </p>
      <p className="text-gray-600">
        <span className="font-medium">User ID:</span> {user.id}
      </p>
      <RoleDisplay />
    </div>
  </div>
);
