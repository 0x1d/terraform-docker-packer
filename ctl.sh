#!/usr/bin/env bash

function info {
  echo "PI-Lab Utils"
}

function build {
  function image {
    docker run --rm --privileged \
      -v /dev:/dev \
      -v ${PWD}:/build mkaczanowski/packer-builder-arm:latest \
      build packer/raspios.pkr.hcl
  }
  ${@:-info}
}

${@:-info}
