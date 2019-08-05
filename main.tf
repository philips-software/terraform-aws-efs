data "aws_vpc" "selected" {
  id = var.vpc_id
}

resource "aws_security_group" "efs_sg" {
  name        = "${var.environment}-efs-sg"
  description = "controls access to efs"

  vpc_id = var.vpc_id

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  tags = merge(
    {
      "Name" = format("%s", "${var.environment}-efs-sg")
    },
    {
      "Environment" = format("%s", var.environment)
    },
    {
      "Project" = format("%s", var.project)
    },
    var.tags,
  )
}

resource "aws_efs_file_system" "efs" {
  encrypted        = var.encrypted
  performance_mode = var.performance_mode
  creation_token   = var.creation_token

  tags = merge(
    {
      "Name" = format("%s", "${var.environment}-efs")
    },
    {
      "Environment" = format("%s", var.environment)
    },
    {
      "Project" = format("%s", var.project)
    },
    var.tags,
  )
}

resource "aws_efs_mount_target" "efs_mount_target" {
  count = var.subnet_count

  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = element(var.subnet_ids, count.index)
  security_groups = [aws_security_group.efs_sg.id]
}

data "template_file" "amazon_linux_cloud_init_part" {
  template = <<EOL
# Install nfs-utils
cloud-init-per once yum_update yum update -y
cloud-init-per once install_nfs_utils yum install -y nfs-utils

# Create $${mount_location} folder
cloud-init-per once mkdir_efs mkdir $${mount_location}

# Mount $${mount_location}
cloud-init-per once mount_efs echo -e '$${efs_dns}:/ $${mount_location} nfs4 nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 0 0' >> /etc/fstab
mount -a
EOL


  vars = {
    efs_dns        = element(aws_efs_mount_target.efs_mount_target.*.dns_name, 0)
    mount_location = var.mount_location
  }
}

