
# Configure Ansible control node

resource "aws_instance" "linux_ec2_public_ansible_controller" {
  ami                         = var.aws_ami_type
  associate_public_ip_address = true
  instance_type               = var.aws_instance_type
  key_name                    = var.key_name
  subnet_id                   = var.vpc.public_subnets[0]
  vpc_security_group_ids      = [var.sg_pub_id]

  tags = {
    Name = "${var.namespace}-EC2-PUBLIC-ANSIBLE-CONTROLLER-${var.instance_name}"
    Enviornment = "${var.enviornment_tag}"
  }

  # Copies the ssh key file to home dir
  provisioner "file" {
    source      = "./${var.key_name}.pem"
    destination = "/home/ubuntu/${var.key_name}.pem"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }
  }

  # Copies Ansible Install Script to tmp dir
    provisioner "file" {
    source      = "./install-ansible-ubuntu.sh"
    destination = "/tmp/install-ansible-ubuntu.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }
  }
  
  # chmod key 400 on EC2 instance
  provisioner "remote-exec" {
    inline = ["chmod 400 ~/${var.key_name}.pem"]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }

  }

  # install Ansible via script

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install-ansible-ubuntu.sh",
      "sudo /tmp/install-ansible-ubuntu.sh",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }

  }

}