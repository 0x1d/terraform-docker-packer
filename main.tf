locals {
  packer_variables_file = "variables.pkrvars.hcl"
  packer_variables = <<-EOT
%{ for key, value in var.packer_variables ~}
${key} = ${try(jsonencode(value), "\"${value}\"")}
%{ endfor ~}
EOT
}

resource "local_file" "packer_variables" {
  filename = local.packer_variables_file
  content  = local.packer_variables
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