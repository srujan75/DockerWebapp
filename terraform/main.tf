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
  description = "Render API key"
  type        = string
}

resource "null_resource" "deploy_to_render" {
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
            "url": "https://github.com/srujan75/DockerWebapp"
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
