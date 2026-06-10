#!/usr/bin/env bash
set -euo pipefail

echo "=== Building DAKKHO Admin for Cloudflare Pages ==="

# Ensure the Cloudflare Pages config is used as next.config.ts
# (no basePath — Cloudflare Pages deploys at root)
if [ -f "next.config.cloudflare-pages.ts" ]; then
  cp next.config.ts next.config.ts.backup 2>/dev/null || true
  cp next.config.cloudflare-pages.ts next.config.ts
  echo "Using next.config.cloudflare-pages.ts (no basePath)"
fi

# API routes are not compatible with static export (output: 'export')
# Move them OUTSIDE src/app so Next.js won't scan them
if [ -d "src/app/api" ]; then
  mv src/app/api /tmp/dakkho-api-backup
  echo "Moved API routes to /tmp (not compatible with static export)"
fi

# Run the Next.js build (output: 'export' will produce ./out directory)
NEXT_PUBLIC_API_BASE_URL="${NEXT_PUBLIC_API_BASE_URL:-https://dakkho-admin-api.dakkho-admin.workers.dev}" npx next build
echo "Build completed"

# Restore API routes
if [ -d "/tmp/dakkho-api-backup" ]; then
  mv /tmp/dakkho-api-backup src/app/api
  echo "Restored API routes"
fi

# Restore original config if backup exists
if [ -f "next.config.ts.backup" ]; then
  mv next.config.ts.backup next.config.ts
  echo "Restored original next.config.ts"
fi

# Fix SPA routing for Cloudflare Pages
rm -f out/_routes.json
echo '/* /index.html 200' > out/_redirects

echo "=== Cloudflare Pages build complete ==="
echo "Static files are in ./out directory, ready for deployment"
echo "API backend: https://dakkho-admin-api.dakkho-admin.workers.dev"
