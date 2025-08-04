// ロガーでトークン、キー、パスワードなどの機密URLデータを隠すため。
export const sanitizeUrl = (url: string): string => {
  return url.replace(/([?&])(token|key|password|secret)=[^&]*/gi, '$1$2=***');
};