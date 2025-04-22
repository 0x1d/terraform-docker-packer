# RaspiOS

Build a ARM64 device image based on RaspiOS.  
The Packer config will run some scripts located at `./scripts` through the Shell provisioner in order to setup and configure the device image.  
In addition, `Firstboot` will be configured to run an additional setup scripts during first boot of the device.  

## Provisioning

```
# run the Packer build
terraform init
terraform apply

# show build progress
docker logs -f $(docker ps -q -f name=packer-builder-arm)
```

The image will have ssh enabled and user `pi` configured with password `raspberry`.  
To change password for the user, modify `./scripts/pi.sh`.
Generate another password with:
```
openssl passwd -6
```

## Firstboot

This example contains a Systemd service and script that will run at first boot and sets the hostname to `rpi-SERIAL` so that each device gets a unique hostname.    
Adopted from https://github.com/nmcclain/raspberian-firstboot