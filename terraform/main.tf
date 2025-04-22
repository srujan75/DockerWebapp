terraform {
  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "~> 3.0"
    }
  }
}

provider "http" {}

variable "render_api_key" {
  description = "API key for Render"
}

resource "http_request" "web_service" {
  url    = "https://api.render.com/v1/services"
  method = "POST"

  headers = {
    Authorization = "Bearer ${var.render_api_key}"
    Content-Type  = "application/json"
  }

  request_body = jsonencode({
    type = "web_service",
    name = "fastapi-app",
    env  = "docker",
    repo = {
      url = "https://github.com/<your_username>/webapp-docker-terraform-render"
    },
    branch        = "main",
    plan          = "free",
    region        = "oregon",
    dockerContext = ".",
    dockerfilePath = "Dockerfile"
  })
}
