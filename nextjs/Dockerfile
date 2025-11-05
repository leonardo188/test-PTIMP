FROM node:20-bullseye AS builder

WORKDIR /app

# 1. Copy package.json dan install dependency
COPY package*.json ./

# 2. Install dependency (pastikan lightningcss dikompilasi ulang)
RUN npm install --force
RUN npm rebuild lightningcss --build-from-source || npm install lightningcss@latest --force

# 3. Copy semua source code
COPY . .

# 4. Pastikan typescript dan tailwind bisa jalan
RUN npm install typescript --save-dev

# 5. Jalankan build
RUN npm run build

# --- Runner ---
FROM node:20-bullseye AS runner
WORKDIR /app
ENV NODE_ENV=production
ENV NEXT_TELEMETRY_DISABLED=1

COPY --from=builder /app ./

EXPOSE 3000
CMD ["npm", "run", "start"]
