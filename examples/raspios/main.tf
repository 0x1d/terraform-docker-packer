module "raspios" {
  source = "../../"
  packer_config = "packer/raspios.pkr.hcl"
  packer_variables = {
    image_path = "rpi-arm64.img"
    scripts = [
      "scripts/pi.sh",
      "scripts/docker.sh",
      "scripts/hashi.sh"
    ]
  }
}