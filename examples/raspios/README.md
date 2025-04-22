# RaspiOS

Build a new ARM64 device image based on RaspiOS.  
The Packer config will run some scripts through the Shell provisioner in order to setup and configure the device image.  
In addition, `Firstboot` will be configured to run an additional setup scripts during first boot of the device.  

## Firstboot

This example contains a Systemd service and script that will run at first boot and sets the hostname to `rpi-SERIAL`.  
Adopted from https://github.com/nmcclain/raspberian-firstboot