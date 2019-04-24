variable "region" {

  default = "ap-southeast-2"
}

variable "aws_access_key" {

  default = ""
}

variable "aws_secret_key" {

  default = ""
}

variable "vpc_cidr" {

  default = "192.168.0.0/24"
}
variable "ssh_ip" {

  default = "121.216.103.158/32"
}
variable "bastionhost_ami" {

  default = "ami-04481c741a0311bbb"
}
variable "appserver_ami" {

  default = "ami-04481c741a0311bbb"
}
variable "ec2_sshkey" {

  default = ""
}

variable "bastion_instancetype" {
  default = "t2.micro"
}

variable "appserver_instancetype" {
  default = "t2.micro"
}
variable "appserver_ip" {
  default="192.168.0.183"

}

variable "az_1" {
  default="ap-southeast-2a"

}

variable "az_2" {
  default="ap-southeast-2b"

}