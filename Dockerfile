# Use Node.js 20 Alpine for smaller image size
FROM node:20-alpine AS base

# Install dependencies stage
FROM base AS deps
RUN apk add --no-cache libc6-compat python3 make g++
WORKDIR /app

# Copy package files
COPY package.json package-lock.json* ./

# Install ALL dependencies using npm install (more flexible than npm ci)
RUN npm install --legacy-peer-deps

# Build the application
FROM base AS builder
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules
COPY . .

# Build Strapi
RUN npm run build

# Production image
FROM base AS runner
WORKDIR /app

ENV NODE_ENV=production
ENV PORT=1337
ENV HOST=0.0.0.0

# Install runtime dependencies
RUN apk add --no-cache libc6-compat

# Copy package files and install production dependencies
COPY package.json package-lock.json* ./
RUN npm install --omit=dev --legacy-peer-deps && \
    npm cache clean --force

# Copy built application from builder
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/build ./build
COPY --from=builder /app/public ./public
COPY --from=builder /app/config ./config
COPY --from=builder /app/database ./database
COPY --from=builder /app/.strapi ./.strapi

# Create necessary directories and set permissions
RUN mkdir -p /tmp && chmod 777 /tmp && \
    addgroup --system --gid 1001 nodejs && \
    adduser --system --uid 1001 strapi && \
    chown -R strapi:nodejs /app

USER strapi

# Expose Strapi port
EXPOSE 1337

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=60s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:1337/ || exit 1

# Start Strapi
CMD ["npm", "run", "start"]