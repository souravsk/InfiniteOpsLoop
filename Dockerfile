# Use an official Node runtime as a base image
FROM node:21-alpine as builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY ./package.json .

# Install dependencies
RUN npm install

# Reset Nx cache
RUN npx nx reset

# Copy the application files to the container
COPY . .

# Build the Angular app
RUN npm run build

# Use Nginx as a lightweight, efficient web server to serve the Angular app
FROM nginx:stable-alpine

#You set the working directory to the default directory where Nginx serves its HTML files.
WORKDIR /usr/share/nginx/html

#rou remove any existing files in the Nginx HTML directory. This is a good practice to ensure a clean slate before copying new files.
RUN rm -rf ./*

# Copy the built Angular app to the Nginx public directory  
COPY --from=builder /app/dist/apps/filmpire .

# Expose the port on which Nginx will run
EXPOSE 80

# Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
