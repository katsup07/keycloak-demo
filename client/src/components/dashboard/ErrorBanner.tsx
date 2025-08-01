import React from 'react';

type Props = {
  message: string;
};

export const ErrorBanner: React.FC<Props> = ({ message }) => (
  <div className="bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 mb-6">
    <p className="font-medium">Note:</p>
    <p>{message}</p>
  </div>
);
