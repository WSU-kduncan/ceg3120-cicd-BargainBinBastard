# Use official Node image as base
FROM node:18-bullseye

# Set working directory inside container
WORKDIR /app

# Copy Angular project files into the container
COPY angular-site/ .

# Install dependencies
RUN npm install

# Build the Angular app
RUN npm run build

# Install the static file server
RUN npm install -g serve

# Expose the port the app will run on
EXPOSE 3000

# Start the Angular app using serve from the built dist folder
CMD ["serve", "-s", "dist/wsu-hw-ng", "-l", "3000"]
