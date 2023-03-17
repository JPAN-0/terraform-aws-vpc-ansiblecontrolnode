output "public_connection_string" {
  description = "Public EC2 instance"
  value       = [for vm in module.test_ec2 :  "ssh -i ${module.test_ssh-key.key_name}.pem ubuntu@${vm.public_ip}"]
}

output "private_connection_string" {
  description = "Private EC2 instance"
  value       = [for vm in module.test_ec2 : "ssh -i ${module.test_ssh-key.key_name}.pem ubuntu@${vm.private_ip}"]
}

output "ansible_contoller_public_connection_string" {
  description = "Ansible controller public IP address"
  value = "ssh -i ${module.test_ssh-key.key_name}.pem ubuntu@${module.test_ec2_ansible.ansible_controller_public_ip}"
}

