#!/usr/bin/env bash

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh ./get-docker.sh
rm get-docker.sh

usermod -aG docker pi