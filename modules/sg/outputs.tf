output "security_group_id" {
  description = "Security Group ID created by this module"
  value       = try(module.web_server_sg.security_group_id, module.web_server_sg.this_security_group_id)
}
