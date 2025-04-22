module "raspios" {
  source = "../../"
  packer_config = "packer/raspios.pkr.hcl"
  provisioning_scripts = [
    "scripts/pi.sh",
    "scripts/docker.sh",
    "scripts/hashi.sh"
  ]
}