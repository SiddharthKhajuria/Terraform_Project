output "ec2_public_ip" {
  description = "Public IP address of the EC2 instance in QA"
  value       = module.ec2.public_ip
}

output "ec2_private_ip" {
  description = "Private IP address of the EC2 instance in QA"
  value       = module.ec2.private_ip
}
