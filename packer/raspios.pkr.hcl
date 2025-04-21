source "arm" "raspios-arm64" {
  file_urls                 = ["https://downloads.raspberrypi.com/raspios_lite_arm64/images/raspios_lite_arm64-2024-11-19/2024-11-19-raspios-bookworm-arm64-lite.img.xz"]
  file_checksum_url         = "https://downloads.raspberrypi.com/raspios_lite_arm64/images/raspios_lite_arm64-2024-11-19/2024-11-19-raspios-bookworm-arm64-lite.img.xz.sha256"
  file_checksum_type        = "sha256"
  file_target_extension     = "xz"
  file_unarchive_cmd        = ["xz", "--decompress", "$ARCHIVE_PATH"]
  image_build_method        = "resize"
  image_path                = "raspios-arm64.img"
  image_size                = "4G"
  image_type                = "dos"

  image_partitions {
    name        = "boot"
    type        = "c"
    start_sector = "8192"
    filesystem  = "vfat"
    size        = "256M"
    mountpoint  = "/boot"
  }

  image_partitions {
    name        = "root"
    type        = "83"
    start_sector = "532480"
    filesystem  = "ext4"
    size        = "0"
    mountpoint  = "/"
  }

  image_chroot_env = ["PATH=/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin"]
  qemu_binary_source_path      = "/usr/bin/qemu-aarch64-static"
  qemu_binary_destination_path = "/usr/bin/qemu-aarch64-static"
}

build {
  sources = ["source.arm.raspios-arm64"]

  provisioner "shell" {
    inline = [
      "touch /boot/ssh.txt",
      "echo 'pi:$6$c70VpvPsVNCG0YR5$l5vWWLsLko9Kj65gcQ8qvMkuOoRkEagI90qi3F/Y7rm8eNYZHW8CY6BOIKwMH7a3YYzZYL90zf304cAHLFaZE0' > /boot/userconf.txt",
      "apt update",
      "apt upgrade -y"
    ]
  }
}
