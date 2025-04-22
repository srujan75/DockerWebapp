$headers = @{
    "Authorization" = "Bearer redis://red-d03mnkbuibrs73ae81fg:6379"
    "Content-Type"  = "application/json"
  }
  
  $body = @{
    type = "web_service"
    name = "fastapi-app"
    env  = "docker"
    repo = @{
      url = "https://github.com/srujan75/webapp-docker-terraform-render"
    }
    branch = "main"
    plan   = "free"
    region = "oregon"
    dockerContext = "."
    dockerfilePath = "Dockerfile"
  } | ConvertTo-Json -Depth 10
  
  Invoke-RestMethod -Uri "https://api.render.com/v1/services" -Method Post -Headers $headers -Body $body
  