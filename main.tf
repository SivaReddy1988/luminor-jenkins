provider "aws"{
  profile	= "default"
  region	= var.region

  # Uncomment access and secret key lines if you wish to specify different credentials in ./variables.tf
  #access_key = var.aws_keys["access"]
  #secret_key = var.aws_keys["secret"]
}

resource "aws_key_pair" "luminor_jenkins" {
  key_name   = "luminor_jenkins"
  public_key = file(var.ssh_pubkey)
}

resource "aws_instance" "jenkins" {
  key_name      = aws_key_pair.luminor_jenkins.key_name
  ami	        	= var.amis[var.region]
  instance_type	= "t2.micro"

  subnet_id     = aws_subnet.subnet10.id
  vpc_security_group_ids = [aws_security_group.jenkins.id]

  connection {
    type          = "ssh"
    user          = "ubuntu"
    private_key   = file(var.ssh_privkey)
    host          = self.public_ip
  }

  provisioner "remote-exec" {
    script      = "install_jenkins.sh"
  }

  tags = {
    Name = "Luminor Jenkins"
  }
}

output "elastic_ip" {
  value = aws_eip.ip.public_ip
}
