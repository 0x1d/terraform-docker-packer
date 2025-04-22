locals {
  packer_variables_file = "variables.pkrvars.hcl"
}

resource "local_file" "packer_variables" {
  filename = local.packer_variables_file
  content = <<-EOT
    scripts = ${jsonencode(var.provisioning_scripts)}
  EOT
}

resource "docker_image" "packer" {
  name         = var.packer_image
  keep_locally = true
}

resource "docker_container" "packer" {
  image = docker_image.packer.image_id
  name  = "packer-builder-arm"
  rm = true
  tty = true
  stdin_open = true
  privileged = true
  command = [
    "build", 
    "-var-file=${local.packer_variables_file}",
    var.packer_config
  ]
  volumes {
    container_path = "/dev"
    host_path = "/dev"
  }
  volumes {
    container_path = "/build"
    host_path = "${path.cwd}"
  }
}