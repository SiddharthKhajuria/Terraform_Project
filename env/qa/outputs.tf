output "ec2_public_ip" {
  description = "Public IP address(es) of EC2 instance(s) in QA"
  value       = module.ec2.public_ip
}

output "ec2_private_ip" {
  description = "Private IP address(es) of EC2 instance(s) in QA"
  value       = module.ec2.private_ip
}
