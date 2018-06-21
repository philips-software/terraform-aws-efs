output "efs_id" {
  description = "Id of the EFS file system."
  value       = "${module.efs.efs_id}"
}

output "efs_dns_name" {
  description = "List of DNS mount points, one per subnet."
  value       = "${module.efs.efs_dns_name}"
}

output "amazon_linux_cloudinit_config_part" {
  description = "Cloud init part to mount an EFS to an EC2 instance."
  value       = "${module.efs.amazon_linux_cloudinit_config_part}"
}
