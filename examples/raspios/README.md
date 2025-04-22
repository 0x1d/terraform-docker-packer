# RaspiOS

Build a new RaspiOS device image.  
The Packer config will run some scripts through the Shell provisioner in order to setup and configure the device image.

## Firstboot

This example contains a Systemd service and script that will run at first boot and sets the hostname to `rpi-SERIAL`.  
Adopted from https://github.com/nmcclain/raspberian-firstboot