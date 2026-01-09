# Builder
FROM oven/bun:latest AS builder
WORKDIR /app

COPY package.json bun.lock* ./
RUN bun install

COPY . .
RUN bun run build

# Production
FROM oven/bun:latest AS production
RUN useradd --user-group --create-home --shell /bin/bash strapi
WORKDIR /app

COPY --from=builder /app /app
RUN chown -R strapi:strapi /app
USER strapi

EXPOSE 1337
CMD ["bun", "run", "start"]
