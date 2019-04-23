
#security groups
#Bastion sg
resource "aws_security_group" "bastion" {

  vpc_id = "${aws_vpc.usecase1.id}"
  tags {
    Name="bastion-sg"
  }
}

#Bastion sg rules
resource "aws_security_group_rule" "sshtobastion" {

  protocol = "tcp"
  security_group_id = "${aws_security_group.bastion.id}"
  from_port = 22
  to_port = 22
  type = "ingress"
  cidr_blocks = ["${var.ssh_ip}"]
  description = "SSH from my I.P"

}


resource "aws_security_group_rule" "bastiontoworld" {


  security_group_id = "${aws_security_group.bastion.id}"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  type = "egress"

}

#sg for ec2 instances in private subnet
resource "aws_security_group" "ec2" {

  vpc_id = "${aws_vpc.usecase1.id}"
  tags {
    Name="ec2-sg"
  }
}

#sg rules for ec2 instances in private subnet
resource "aws_security_group_rule" "bastiontoec2" {

  protocol = "-1"
  security_group_id = "${aws_security_group.ec2.id}"
  from_port = 0
  to_port = 0
  type = "ingress"
  source_security_group_id = "${aws_security_group.bastion.id}"
  description = "All traffic from bastion host"
}


resource "aws_security_group_rule" "ec2toworld" {


  security_group_id = "${aws_security_group.ec2.id}"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  type = "egress"
}