# Use the official Node.js 14 image as the base image
FROM node:18

# Set the working directory to /app
WORKDIR /app

# Copy the package.json and package-lock.json files to the container
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the rest of the application code to the container
COPY . .

# Build the Vue app for production
RUN npm run build

# Expose port 8080 for the container
EXPOSE 8080

# Start the server
CMD ["npm", "run", "serve"]