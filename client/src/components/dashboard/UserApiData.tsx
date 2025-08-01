import React from 'react';

type Props = {
  userData: any;
  userProfile: any;
};

export const UserApiData: React.FC<Props> = ({ userData, userProfile }) => (
  <div className="bg-white rounded-lg shadow-md p-6 h-full w-[40rem]">
    <h2 className="text-xl font-semibold text-gray-800 mb-4">API Data</h2>
    {userData ? (
      <div>
        <h3 className="font-medium text-gray-700 mb-2">User Data:</h3>
        <pre className="bg-gray-50 p-4 rounded text-sm w-full">
          {JSON.stringify(userData, null, 2)}
        </pre>
      </div>
    ) : (
      <p className="text-gray-500">No user data available from API</p>
    )}
    {userProfile ? (
      <div>
        <h3 className="font-medium text-gray-700 mb-2">User Profile:</h3>
        <pre className="bg-gray-50 p-4 rounded text-sm w-full">
          {JSON.stringify(userProfile, null, 2)}
        </pre>
      </div>
    ) : (
      <p className="text-gray-500">No profile data available from API</p>
    )}
  </div>
);
