import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

// inject Content Security Policy meta tag
const injectCspMetaTag = () => {
  return {
    name: 'csp-plugin',
    transformIndexHtml(html: string) {
      const csp = "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline'; connect-src 'self' http://localhost:8080 http://localhost:8081 http://localhost:8082 ws://localhost:3000; frame-src 'self' http://localhost:8080; img-src 'self' data:; font-src 'self';"
      
      return html.replace(
        '<head>',
        `<head>\n    <meta http-equiv="Content-Security-Policy" content="${csp}">`
      )
    }
  }
}

// https://vite.dev/config/
export default defineConfig({
  plugins: [react(), injectCspMetaTag()],
  resolve: {
    alias: {
      '@': path.resolve(__dirname, './src'),
    },
  },
  server: {
    port: 3000,
    proxy: {
      '/api': {
        target: 'http://localhost:8081',
        changeOrigin: true,
        secure: false,
      }
    }
  }
})
