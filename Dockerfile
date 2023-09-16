# Use an official Node.js runtime as the base image
FROM node:18 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the app source code to the working directory
COPY . .

# Build the Vue 3 app using Vite
RUN npm run build

# Use Nginx as the production server
FROM nginx:alpine

# Copy the built app from the previous stage to the Nginx default HTML directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 for the Nginx server
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
