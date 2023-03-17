output "public_ip" {
  value = aws_instance.linux_ec2_public.public_ip
}

output "private_ip" {
  value = aws_instance.linux_ec2_private.private_ip
}