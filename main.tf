data "aws_subnet" "web" {
  id = var.subnet_id
}

data "aws_ami" "web" {
  most_recent = true

  filter {
    name   = "image-id"
    values = [var.ami_id]
  }
}

data "aws_key_pair" "web" {
  key_name = var.key_pair
}

data "aws_ec2_instance_type" "web" {
	instance_type = var.instance_type
}

resource "aws_security_group" "web" {
  name        = var.name
  description = "Allow SSH and HTTP inbound traffic and all outbound traffic"
  vpc_id      = data.aws_subnet.web.vpc_id

  tags = {
    Name = var.name
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = var.public_cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = var.public_cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.web.id
  instance_type = data.aws_ec2_instance_type.web.instance_type
  key_name      = data.aws_key_pair.web.key_name

  subnet_id                   = data.aws_subnet.web.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  user_data_replace_on_change = true
  user_data                   = <<EOF
#!/bin/sh

dnf install -y nginx

cat <<EOT > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html>
<head>
<title>Hello!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Hi Randy!</h1>
<p>This page is running via nginx.</p>
</body>
</html>
EOT

systemctl start nginx && systemctl enable nginx
EOF

  tags = {
    Name = var.name
  }
}
