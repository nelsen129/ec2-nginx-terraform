variable "name" {
  description = "Name to apply to resources"
  type        = string
  default     = "ec2-nginx-terraform"
}

variable "subnet_id" {
  description = "ID of the subnet to place the EC2 instance in"
  type        = string
}

variable "public_cidr_block" {
  description = "Public CIDR block to allow external SSH and HTTP access to EC2 instance"
  type        = string
  default     = "0.0.0.0/0"
}
