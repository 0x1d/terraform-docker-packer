#!/usr/bin/env bash

# enable ssh
touch /boot/ssh.txt

# configure user
echo 'pi:$6$c70VpvPsVNCG0YR5$l5vWWLsLko9Kj65gcQ8qvMkuOoRkEagI90qi3F/Y7rm8eNYZHW8CY6BOIKwMH7a3YYzZYL90zf304cAHLFaZE0' > /boot/userconf.txt

# enable firstboot.service
cd /etc/systemd/system/multi-user.target.wants && ln -s /lib/systemd/system/firstboot.service .