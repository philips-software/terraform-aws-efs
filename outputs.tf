output "efs_id" {
  description = "Id of the EFS file system."
  value       = aws_efs_file_system.efs.id
}

output "efs_dns_name" {
  description = "List of DNS mount points, one per subnet."
  value       = [aws_efs_mount_target.efs_mount_target.*.dns_name]
}

output "amazon_linux_cloudinit_config_part" {
  description = "Cloud init part to mount an EFS to an EC2 instance."

  value = {
    content_type = "text/cloud-boothook"
    content      = data.template_file.amazon_linux_cloud_init_part.rendered
  }
}

