FROM node:20-slim
WORKDIR /app
COPY dist/ ./dist/
COPY package.json ./
COPY start.sh ./
COPY .gitignore ./
ENV NODE_ENV=production
ENV PORT=5000
EXPOSE 5000
CMD ["bash", "start.sh"]
