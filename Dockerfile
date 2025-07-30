# Use official Node.js 18 image
FROM node:18-alpine AS base

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json yarn.lock ./
# Set registry explicitly and increase network timeout to help with network issues

RUN yarn config delete https-proxy
RUN yarn config delete proxy

RUN yarn config get https-proxy
RUN yarn config get proxy
RUN yarn cache clean
RUN yarn install --network-timeout 1000000


# Copy the rest of the application code
COPY . .

# Build the Remix app
RUN yarn build

# Expose port (Remix default)
EXPOSE 3000

# Note: Add your .env file at build or runtime as needed

# Start the app
CMD ["yarn", "dev"] 
