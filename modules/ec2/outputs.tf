output "instance_id" {
  description = "IDs of the EC2 instances"
  value       = [for instance in module.ec2_instance : instance.id]
}

output "private_ip" {
  description = "Private IP addresses of the EC2 instances"
  value       = [for instance in module.ec2_instance : instance.private_ip]
}

output "public_ip" {
  description = "Public IP addresses of the EC2 instances"
  value       = [for instance in module.ec2_instance : instance.public_ip]
}
