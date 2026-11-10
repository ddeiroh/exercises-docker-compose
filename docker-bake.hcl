group "default" {
  targets = ["frontend", "backend"]
}

target "frontend" {
  context = "example-app"
  dockerfile = "Dockerfile.frontend"
  tags = ["frontend"]
}

target "backend" {
  context = "example-app"
  dockerfile = "Dockerfile.backend"
  tags = ["backend"]
}
