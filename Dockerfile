# Use the official Node.js image as a base
FROM node:18.16.0-alpine

# Install pnpm globally
RUN npm install -g pnpm@9

# Set the working directory inside the container
WORKDIR /app

# Copy package.json, pnpm-lock.yaml and .npmrc if exists
COPY package.json pnpm-lock.yaml* ./

# Install dependencies using pnpm
RUN pnpm install --frozen-lockfile

# Copy the rest of the Strapi project files
COPY . .

# Expose the port that Strapi will run on
EXPOSE 1337

# Build Strapi
RUN pnpm build

# Start Strapi in production mode
CMD ["pnpm", "start"]
