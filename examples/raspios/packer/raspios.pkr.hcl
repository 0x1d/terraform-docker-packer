variable "image_url" {
  type    = string
  default = "https://downloads.raspberrypi.com/raspios_lite_arm64/images/raspios_lite_arm64-2024-11-19/2024-11-19-raspios-bookworm-arm64-lite.img.xz"
}

variable "image_path" {
  type    = string
  default = "raspios-arm64.img"
}

variable "scripts" {
  type = list(string)
  default = []
}

source "arm" "raspios-arm64" {
  file_urls             = ["${var.image_url}"]
  file_checksum_url     = "${var.image_url}.sha256"
  file_checksum_type    = "sha256"
  file_target_extension = "xz"
  file_unarchive_cmd    = ["xz", "--decompress", "$ARCHIVE_PATH"]
  image_build_method    = "resize"
  image_path            = var.image_path
  image_size            = "4G"
  image_type            = "dos"

  image_partitions {
    name         = "boot"
    type         = "c"
    start_sector = "8192"
    filesystem   = "vfat"
    size         = "256M"
    mountpoint   = "/boot"
  }

  image_partitions {
    name         = "root"
    type         = "83"
    start_sector = "532480"
    filesystem   = "ext4"
    size         = "0"
    mountpoint   = "/"
  }

  image_chroot_env = ["PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"]
  qemu_binary_source_path      = "/usr/bin/qemu-aarch64-static"
  qemu_binary_destination_path = "/usr/bin/qemu-aarch64-static"
}

build {
  sources = ["source.arm.raspios-arm64"]

  provisioner "file" {
    source = "rootfs/lib/systemd/system/firstboot.service"
    destination = "/lib/systemd/system/firstboot.service"
  }

  provisioner "file" {
    source = "rootfs/lib/firstboot.sh"
    destination = "/lib/firstboot.sh"
  }

  provisioner "shell" {
    scripts = var.scripts
  }
}
