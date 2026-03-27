# Use the official, lightweight Nginx image
FROM nginx:alpine

# Copy everything from your repo (except what's in .dockerignore) to the web folder
COPY . /usr/share/nginx/html/

# Expose port 80 for the container
EXPOSE 80
