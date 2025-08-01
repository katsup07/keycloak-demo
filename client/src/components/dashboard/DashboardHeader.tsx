import React from 'react';

type Props = {
  title: string;
  loading: boolean;
  onTest: () => void;
};

export const DashboardHeader: React.FC<Props> = ({ title, loading, onTest }) => (
  <div className="flex justify-between items-center mb-8">
    <h1 className="text-3xl font-bold text-white">{title}</h1>
    <button
      onClick={onTest}
      disabled={loading}
      className="bg-blue-600 hover:bg-blue-700 disabled:bg-blue-300 text-white px-4 py-2 rounded-lg transition-colors duration-200 cursor-pointer"
    >
      {loading ? 'Testing...' : 'Test API Calls'}
    </button>
  </div>
);
