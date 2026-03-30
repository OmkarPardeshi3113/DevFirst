# Use the lightweight Alpine Linux version of Nginx
FROM nginx:alpine

# Copy everything from your GitHub repo into the Docker container's web directory
COPY . /usr/share/nginx/html
