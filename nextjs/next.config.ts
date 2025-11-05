import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  experimental: {
    optimizeCss: false,
  },

  reactCompiler: true,

  webpack: (config: any) => {
    config.resolve.fallback = {
      ...config.resolve.fallback,
      "lightningcss": false,
    }
    return config
  },

  env: {
    NEXT_PUBLIC_API_URL: process.env.NEXT_PUBLIC_API_URL || "http://laravel:8000/api",
  },

  typescript: {
    ignoreBuildErrors: true,
  },
};

export default nextConfig;
