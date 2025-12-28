FROM node:18-alpine

WORKDIR /app

# Install system dependencies
RUN apk add --no-cache \
    libc6-compat \
    python3 \
    make \
    g++ \
    vips-dev

# Copy package files
COPY package.json package-lock.json* ./

# Install ALL dependencies
RUN npm install

# Copy application code
COPY . .

# Build Strapi admin
ENV NODE_ENV=production
RUN npm run build

# Clean up dev dependencies
RUN npm prune --production

# Expose port
EXPOSE 1337

# Start Strapi
CMD ["npm", "run", "start"]