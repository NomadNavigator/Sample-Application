provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0705384c0b33c194c"
  instance_type = "t3.micro"
  key_name      = "aws-log"  # Name of the key pair created in AWS

  tags = {
    Name = "DevOps-Wizard-Web-App"
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
      private_key = file("~/.ssh/id_rsa")  # Path to your private key
      host        = self.public_ip
    }
  }
}
