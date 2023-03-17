output "ansible_controller_public_ip" {
  value = aws_instance.linux_ec2_public_ansible_controller.public_ip  
}