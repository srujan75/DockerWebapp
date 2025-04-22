terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "null" {}

variable "render_api_key" {
  description = "API key for Render"
  type        = string
}

resource "null_resource" "create_render_service" {
  provisioner "local-exec" {
    command = <<EOT
      curl -X POST https://api.render.com/v1/services \
      -H "Authorization: Bearer ${var.render_api_key}" \
      -H "Content-Type: application/json" \
      -d '{
        "type": "web_service",
        "name": "fastapi-app",
        "env": "docker",
        "repo": {
          "url": "https://github.com/srujan75/webapp-docker-terraform-render"
        },
        "branch": "main",
        "plan": "free",
        "region": "oregon",
        "dockerContext": ".",
        "dockerfilePath": "Dockerfile"
      }'
    EOT
    interpreter = ["/bin/bash", "-c"]
   }
}
