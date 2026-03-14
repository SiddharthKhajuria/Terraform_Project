output "ec2_public_ip" {
  description = "Public IP address(es) of public-subnet EC2 instance(s) in QA"
  value       = module.ec2_public.public_ip
}

output "ec2_private_ip" {
  description = "Private IP address(es) of private-subnet EC2 instance(s) in QA"
  value       = module.ec2_private.private_ip
}

output "ec2_all_private_ip" {
  description = "Private IP address(es) of all EC2 instance(s) in QA"
  value       = concat(module.ec2_public.private_ip, module.ec2_private.private_ip)
}
