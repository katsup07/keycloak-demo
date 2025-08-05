/**
 * Get size limit information for API responses
 */
export const getSizeLimitInfo = () => {
  return {
    json: process.env.REQUEST_SIZE_LIMIT_JSON || '10mb',
    urlencoded: process.env.REQUEST_SIZE_LIMIT_URLENCODED || '10mb',
    raw: process.env.REQUEST_SIZE_LIMIT_RAW || '100mb',
    text: process.env.REQUEST_SIZE_LIMIT_TEXT || '1mb'
  };
};