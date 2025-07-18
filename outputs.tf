output "instance_arn" {
  description = "The ARN of the created EC2 instance"
  value       = aws_instance.web.arn
}

output "instance_id" {
  description = "The ID of the created EC2 instance"
  value       = aws_instance.web.id
}

output "instance_public_dns" {
  description = "The public DNS name of the created EC2 instance"
  value       = aws_instance.web.public_dns
}

output "instance_public_ip" {
  description = "The public IP address of the created EC2 instance"
  value       = aws_instance.web.public_ip
}

