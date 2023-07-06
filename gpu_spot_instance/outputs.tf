output "ubuntu_ip" {
  value       = aws_eip.ip-vps-env.public_ip
  description = "Spot intstance IP"
}
