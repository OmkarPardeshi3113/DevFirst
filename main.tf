terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

# Tell Terraform to communicate with your local Docker engine
provider "docker" {}

# Define the container we want to run
resource "docker_container" "portfolio" {
  image = "omkar-portfolio:latest"
  name  = "portfolio-container"
  
  # If a container with this name exists, Terraform will destroy it and recreate it with the new image
  rm = true 

  ports {
    internal = 80
    external = 8081 
  }
}
