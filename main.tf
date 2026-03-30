terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  # Connects to the local Docker socket exposed by Docker Desktop to WSL
  host = "unix:///var/run/docker.sock"
}

# 1. Build the Docker image using your existing Dockerfile
resource "docker_image" "nginx_website" {
  name = "my-terraform-website:latest"
  build {
    context = "."
  }
}

# 2. Run the container and map the ports
resource "docker_container" "nginx_container" {
  name  = "terraform-running-website"
  image = docker_image.nginx_website.image_id
  ports {
    internal = 80
    external = 8081
  }
}
