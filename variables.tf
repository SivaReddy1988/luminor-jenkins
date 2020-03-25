variable "region"{
  default	= "eu-central-1"
}

variable "amis" {
  type = map(string)
  default = {
    "eu-central-1" = "ami-0b418580298265d5c" # Ubuntu Server 18.04
    "eu-west-1" = "ami-035966e8adab4aaad" # Ubuntu Server 18.04
  }
}

# Place your API keys here and uncomment main.tf lines
variable "aws_keys" {
  type = map(string)
  default = {
    "access" = "YOUR-ACCESS-KEY"
    "secret" = "YOUR-SECRET-KEY"
  }
}

# Public key location
variable "ssh_pubkey"{
  default = "~/.ssh/luminor_jenkins.pub"
}

# Private key location
variable "ssh_privkey"{
  default = "~/.ssh/luminor_jenkins"
}