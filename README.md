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


### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| encrypted | Encrypt file system. | string | `true` | no |
| environment | Name of the environment (e.g. cheetah-dev); will be prefixed to all resources | string | - | yes |
| project | Name of the project. | string | - | yes |
| creation_token | Creation token. | string | - | no |
| mount_location | Used to create a cloud init config part for amazon linux instances. | string | `/efs` | no |
| performance_mode | maxIO | string | `generalPurpose` | no |
| subnet_count |  | string | - | yes |
| subnet_ids | The created EFS will be available in these subnet ids | list | - | yes |
| vpc_id | EFS is created in this VPC | string | - | yes |

### Outputs

| Name | Description |
|------|-------------|
| amazon_linux_cloudinit_config_part | Cloud init part to mount an EFS to an EC2 instance. |
| efs_dns_name | List of DNS mount points, one per subnet. |
| efs_id | Id of the EFS file system. |


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
