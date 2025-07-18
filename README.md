# ec2-nginx-terraform

Basic Terraform configuration for an EC2 instance with NGINX

This repo was created as a simple deployment that provisions an EC2 instance in AWS with a security group allowing SSH access, with a Bash script that installs and starts Nginx on the instance.

## Next steps

Here is a list of next steps to improve the functionality and robustness of this configuration:

- Add actual website content to the files that Nginx is serving.
- Move index.html and other static files to an external data source that the EC2 instance can pull from on start-up, like S3.
- Change the AMI into a pre-hardened AMI with required software already installed.
- Move the EC2 instance into an autoscaling group across multiple AZs for high availability
- Add a load balancer to route traffic across the EC2 instances in the autoscaling group
- Add DNS support
- Add HTTPS/TLS support
- Add CI/CD to the Terraform configuration
