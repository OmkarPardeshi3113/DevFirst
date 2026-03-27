terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.9.0" # <--- This is the fix
    }
  }
}

provider "docker" {}

resource "docker_container" "portfolio" {
  image = "omkar-portfolio:latest"
  name  = "portfolio-container"
  rm    = true 

  ports {
    internal = 80
    external = 8081 
  }
}
