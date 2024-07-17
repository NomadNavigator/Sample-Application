provider "aws" {
  region = "eu-north-1"
}

variable "private_key_content" {
  description = "Contents of the private key"
  type        = string
}

resource "aws_instance" "web" {
  ami           = "ami-0705384c0b33c194c"
  instance_type = "t3.micro"
  key_name      = "aws-log"  # Ensure this matches the key pair name in AWS

  tags = {
    Name = "DevOps-Wizard-Web"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo docker run -d -p 80:8080 daraye/devops-wizard-app:latest"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"  # or "ubuntu" depending on the AMI
      private_key = var.private_key_content  # Use the variable for the private key content
      host        = self.public_ip
    }
  }
}

