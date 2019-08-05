# Terraform module for EFS

This repo contains a terraform module to create an EFS.

## Usage

### Limitations
Due to a bug in the AWS provider for terraform the number of subnets needs to be specified explicitly. See https://github.com/terraform-providers/terraform-provider-aws/issues/1938

### Example usages
```
module "efs" {
  source = "philips-software/efs/aws"
  version = "1.0.0"

  # Or via github
  # source = "github.com/philips-software/terraform-aws-efs?ref=1.0.0"

  environment    = "${var.environment}"
  subnet_count   = "3"
  subnet_ids     = "${var.private_subnet_ids}"
  vpc_id         = "${var.vpc_id}"
}

# The EFS module outputs user_data parts, which can be used in the following way.
data "template_cloudinit_config" "config" {

  ... other parts ....

  part {
    content_type = "${module.efs.amazon_linux_cloudinit_config_part["content_type"]}"
    content      = "${module.efs.amazon_linux_cloudinit_config_part["content"]}"
  }
}

```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| creation\_token | A unique name (a maximum of 64 characters are allowed) used as reference when creating the Elastic File System to ensure idempotent file system creation. By default generated by Terraform. | string | `""` | no |
| encrypted | Encrypt file system. | bool | `"true"` | no |
| environment | Name of the environment; will be prefixed to all resources | string | n/a | yes |
| mount\_location | Used to create a cloud init config part for amazon linux instances. | string | `"/efs"` | no |
| performance\_mode | maxIO | string | `"generalPurpose"` | no |
| project | Name of the project. | string | n/a | yes |
| subnet\_count | Number of subnets. | string | n/a | yes |
| subnet\_ids | The created EFS will be available in these subnet ids | list(string) | n/a | yes |
| tags | A map of tags to add to the resources | map(string) | `<map>` | no |
| vpc\_id | EFS is created in this VPC | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| amazon\_linux\_cloudinit\_config\_part | Cloud init part to mount an EFS to an EC2 instance. |
| efs\_dns\_name | List of DNS mount points, one per subnet. |
| efs\_id | Id of the EFS file system. |

## Philips Forest

This module is part of the Philips Forest.

```
                                                     ___                   _
                                                    / __\__  _ __ ___  ___| |_
                                                   / _\/ _ \| '__/ _ \/ __| __|
                                                  / / | (_) | | |  __/\__ \ |_
                                                  \/   \___/|_|  \___||___/\__|  

                                                                 Infrastructure
```

Talk to the forestkeepers in the `forest`-channel on Slack.

[![Slack](https://philips-software-slackin.now.sh/badge.svg)](https://philips-software-slackin.now.sh)
