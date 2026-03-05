output "instance_id" {
  description = "ID of the EC2 instance"
  value       = try(module.ec2_instance.id, null)
}

output "private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = try(module.ec2_instance.private_ip, null)
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = try(module.ec2_instance.public_ip, null)
}
