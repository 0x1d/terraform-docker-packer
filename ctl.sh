#!/usr/bin/env bash

function info {
  echo "Lab Utils"
}

function build {
  function image {
    terraform apply
    docker logs -f $(docker ps -q -f name=packer-builder-arm)
  }
  ${@:-info}
}

function flash {
  local input_file=${1:-raspios-arm64.img}
  local output_file=${2:-$(lsblk -d -o NAME | fzf --height=10 --prompt="Select a block device: " | sed 's/^/\/dev\//')}

  [[ -z "$input_file" ]] && die "No device image selected."
  [[ -z "$output_file" ]] && die "No block device selected."

  confirm "Flash ${input_file} to ${output_file}?" && {
    echo "Proceeding..."
    sudo dd if=${input_file} of=${output_file} bs=4M status=progress oflag=sync
  } || {
    echo "Aborting."
    exit 1
  }
}

function confirm {
  read -p "$1 (Y/N): " -n 1 -r; echo
  [[ $REPLY =~ ^[Yy]$ ]]
}

function die {
  echo "$1" >&2
  exit 1
}

${@:-info}
