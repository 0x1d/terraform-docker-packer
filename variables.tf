variable "packer_image" {
  type = string
  default  = "mkaczanowski/packer-builder-arm:latest"
}

variable "packer_config" {
  type = string
}

variable "provisioning_scripts" {
  type = list(string)
  default = []
}
