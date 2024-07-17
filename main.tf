provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0705384c0b33c194c"
  instance_type = "t3.micro"

  tags = {
    Name = "DevOps-Wizard-Web"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo docker run -d -p 80:8080 $daraye/devops-wizard-app:latest"
    ]
  }
}
