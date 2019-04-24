#NACL
resource "aws_network_acl" "public1" {
  vpc_id = "${aws_vpc.usecase1.id}"
  tags {
    Name="public1"
  }
  subnet_ids = ["${aws_subnet.public1.id}"]
}
resource "aws_network_acl" "public2" {
  vpc_id = "${aws_vpc.usecase1.id}"
  tags {
    Name="public2"
  }

  subnet_ids = ["${aws_subnet.public2.id}"]
}

resource "aws_network_acl" "private3And4" {
  vpc_id = "${aws_vpc.usecase1.id}"
  tags {
    Name="private3&4"
  }
  subnet_ids = ["${aws_subnet.private3.id}","${aws_subnet.private4.id}"]
}

#NACl public1 Ingress Rules

resource "aws_network_acl_rule" "public1_sshiboundaccess" {
  network_acl_id = "${aws_network_acl.public1.id}"
  protocol = "tcp"
  rule_action = "allow"
  rule_number = 110
  cidr_block = "${var.ssh_ip}"
  from_port      = 22
  to_port        = 22
}
resource "aws_network_acl_rule" "public1_ephemeralinboundaccess" {
  network_acl_id = "${aws_network_acl.public1.id}"
  protocol = "tcp"
  rule_action = "allow"
  rule_number = 120
  cidr_block = "${var.vpc_cidr}"
  from_port      = 1024
  to_port        = 65535
}

#NACl public1 Egress Rules
resource "aws_network_acl_rule" "public1_sshoutboundaccess" {
  network_acl_id = "${aws_network_acl.public1.id}"
  protocol = "tcp"
  rule_action = "allow"
  rule_number = 120
  cidr_block = "${var.vpc_cidr}"
  from_port      = 22
  to_port        = 22
  egress = true
}

resource "aws_network_acl_rule" "public1_ephemeraloutboundaccess" {
  network_acl_id = "${aws_network_acl.public1.id}"
  protocol = "tcp"
  rule_action = "allow"
  rule_number = 110
  cidr_block = "${var.ssh_ip}"
  from_port      = 1024
  to_port        = 65535
  egress = true
}

#NACl public2 Ingress Rules
resource "aws_network_acl_rule" "public2_httpsinboundaccess" {
  network_acl_id = "${aws_network_acl.public2.id}"
  protocol = "tcp"
  rule_action = "allow"
  rule_number = 110
  cidr_block = "${var.vpc_cidr}"
  from_port      = 443
  to_port        = 443
}
resource "aws_network_acl_rule" "public2_ephemeralinboundaccess" {
  network_acl_id = "${aws_network_acl.public2.id}"
  protocol = "tcp"
  rule_action = "allow"
  rule_number = 120
  cidr_block = "0.0.0.0/0"
  from_port      = 1024
  to_port        = 65535
}
resource "aws_network_acl_rule" "public2_icmpinboundaccess" {
  network_acl_id = "${aws_network_acl.public2.id}"
  protocol = "icmp"
  rule_action = "allow"
  rule_number = 130
  cidr_block = "0.0.0.0/0"
  icmp_type = "-1"
  icmp_code = "-1"
  from_port = "-1"
  to_port = "-1"


}

#NACl public2 Engress Rules

resource "aws_network_acl_rule" "public2_httpsoutboundaccess" {
  network_acl_id = "${aws_network_acl.public2.id}"
  protocol = "tcp"
  rule_action = "allow"
  rule_number = 110
  cidr_block = "0.0.0.0/0"
  from_port      = 443
  to_port        = 443
  egress = true
}
resource "aws_network_acl_rule" "public2_ephemeraloutboundaccess" {
  network_acl_id = "${aws_network_acl.public2.id}"
  protocol = "tcp"
  rule_action = "allow"
  rule_number = 120
  cidr_block = "${var.vpc_cidr}"
  from_port      = 1024
  to_port        = 65535
  egress = true
}
resource "aws_network_acl_rule" "public2_icmpoutboundaccess" {
  network_acl_id = "${aws_network_acl.public2.id}"
  protocol = "icmp"
  rule_action = "allow"
  rule_number = 130
  cidr_block = "0.0.0.0/0"
  icmp_type = "-1"
  icmp_code = "-1"
  from_port = "-1"
  to_port = "-1"
  egress = true

}

#NACl private3&4 Ingress Rules

resource "aws_network_acl_rule" "private_sshinboundaccess" {
  network_acl_id = "${aws_network_acl.private3And4.id}"
  protocol = "tcp"
  rule_number = 110
  cidr_block = "192.168.0.0/26"
  rule_action = "allow"
  from_port = "22"
  to_port =  "22"
}
resource "aws_network_acl_rule" "private_icmpinboundaccess" {
  network_acl_id = "${aws_network_acl.private3And4.id}"
  protocol = "icmp"
  rule_number = 120
  cidr_block = "0.0.0.0/0"
  rule_action = "allow"
  icmp_code = "-1"
  icmp_type = "-1"
  from_port = "-1"
  to_port =  "-1"
}

resource "aws_network_acl_rule" "private_ephemeralinboundaccess" {
  network_acl_id = "${aws_network_acl.private3And4.id}"
  protocol = "tcp"
  rule_action = "allow"
  rule_number = 130
  cidr_block = "0.0.0.0/0"
  from_port   = 1024
  to_port      = 65535
}

#NACl private3&4 Egress Rules

resource "aws_network_acl_rule" "private_httpsoutboundaccess" {
  network_acl_id = "${aws_network_acl.private3And4.id}"
  protocol = "tcp"
  rule_number = 110
  cidr_block = "0.0.0.0/0"
  rule_action = "allow"
  from_port = "443"
  to_port =  "443"
  egress = true
}
resource "aws_network_acl_rule" "private_icmpoutboundaccess" {
  network_acl_id = "${aws_network_acl.private3And4.id}"
  protocol = "icmp"
  rule_number = 120
  cidr_block = "0.0.0.0/0"
  rule_action = "allow"
  icmp_code = "-1"
  icmp_type = "-1"
  from_port = "-1"
  to_port =  "-1"
  egress = true
}

resource "aws_network_acl_rule" "private_ephemeraloutboundaccess" {
  network_acl_id = "${aws_network_acl.private3And4.id}"
  protocol = "tcp"
  rule_action = "allow"
  rule_number = 130
  cidr_block = "0.0.0.0/0"
  from_port   = 1024
  to_port      = 65535
  egress = true
}


