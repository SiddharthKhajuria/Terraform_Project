output "security_group_id" {
  description = "Security Group ID created by this module"
  value       = aws_security_group.web_server_sg.id
}
