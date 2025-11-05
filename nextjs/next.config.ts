/** @type {import('next').NextConfig} */
const nextConfig = {
  // Enable standalone output for Docker
  output: 'standalone',
  
  experimental: {
    // Disable CSS optimization to prevent lightningcss issues
    optimizeCss: false,
  },

  reactCompiler: true,

  typescript: {
    ignoreBuildErrors: true,
  },
};

export default nextConfig;
