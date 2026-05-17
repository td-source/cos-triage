FROM node:20-slim

# better-sqlite3 needs build tools to compile native bindings
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 make g++ \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package.json ./
RUN npm install --omit=dev --no-audit --no-fund

COPY dist/ ./dist/
COPY start.sh ./
RUN chmod +x start.sh

ENV NODE_ENV=production
ENV PORT=5000
EXPOSE 5000
CMD ["bash", "start.sh"]
