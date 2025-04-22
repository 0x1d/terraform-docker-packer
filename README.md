# Terraform Docker Packer

This Terraform module serves as an abstraction to builds machine images from Packer configurations through Docker.  
A pre-existing Docker image with Packer installed is required.  
  
You may run the example to build a RaspiOS ARM64 image:
```
pushd examples/raspios
    terraform init
    terraform apply
    docker logs -f $(docker ps -q -f name=packer-builder-arm)
popd
```

## Build Progress

The build runs in the background and outpout the image to the local directory.  
To see the build progress, you need to show the Docker logs like this:
```
docker logs -f $(docker ps -q -f name=packer-builder-arm)
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_docker"></a> [docker](#requirement\_docker) | ~> 3.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_docker"></a> [docker](#provider\_docker) | 3.0.2 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [docker_container.packer](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/container) | resource |
| [docker_image.packer](https://registry.terraform.io/providers/kreuzwerker/docker/latest/docs/resources/image) | resource |
| [local_file.packer_variables](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_packer_config"></a> [packer\_config](#input\_packer\_config) | n/a | `string` | n/a | yes |
| <a name="input_packer_image"></a> [packer\_image](#input\_packer\_image) | n/a | `string` | `"mkaczanowski/packer-builder-arm:latest"` | no |
| <a name="input_packer_variables"></a> [packer\_variables](#input\_packer\_variables) | n/a | `any` | n/a | yes |

## Outputs

No outputs.
