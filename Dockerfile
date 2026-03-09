# Use the official, lightweight Nginx image
FROM nginx:alpine

# Copy our HTML file into the container's web directory
COPY index.html /usr/share/nginx/html/index.html

# Expose port 80 to the outside world
EXPOSE 80
