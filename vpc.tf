#VPC

resource "aws_vpc" "usecase1" {
  cidr_block = "${var.vpc_cidr}"
  tags = {
    Name = "usecase1"
  }
  enable_dns_hostnames = true
}

#Internet Gateway
resource "aws_internet_gateway" "usecase1_igw" {
  vpc_id = "${aws_vpc.usecase1.id}"

  tags = {
    Name = "usecase1_igw"
  }
}

resource "aws_eip" "nat" {
  vpc=true
}

#NAT Gateway
resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public2.id}"

  tags = {
    Name = "gw_NAT"
  }
}



#Subnets

resource "aws_subnet" "private3" {
  cidr_block = "192.168.0.128/26"
  vpc_id = "${aws_vpc.usecase1.id}"
  availability_zone = "us-east-1a"
  tags {
    Name="private3"
  }

}
resource "aws_subnet" "private4" {
  cidr_block = "192.168.0.192/26"
  vpc_id = "${aws_vpc.usecase1.id}"
  availability_zone = "us-east-1b"
  tags {
    Name="private4"
  }
}
resource "aws_subnet" "public1" {
  cidr_block = "192.168.0.0/26"
  vpc_id = "${aws_vpc.usecase1.id}"
  availability_zone = "us-east-1a"
  tags {
    Name="public1"
  }
}

resource "aws_subnet" "public2" {
  cidr_block = "192.168.0.64/26"
  vpc_id = "${aws_vpc.usecase1.id}"
  availability_zone = "us-east-1b"
  tags {
    Name="public2"
  }
}

#RouteTable

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.usecase1.id}"
  tags {
    Name="private"
  }

}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.usecase1.id}"

  tags {
    Name="public"
  }
}

#routes

/*resource "aws_route" "private_localroute" {

  route_table_id = "${aws_route_table.private.id}"
  depends_on = ["aws_route_table.private"]
}
*/
resource "aws_route" "public_igw_route" {

  route_table_id = "${aws_route_table.public.id}"
  gateway_id="${aws_internet_gateway.usecase1_igw.id}"
  destination_cidr_block="0.0.0.0/0"
  depends_on = ["aws_route_table.public","aws_internet_gateway.usecase1_igw"]
}

resource "aws_route" "private_nat_route" {

  route_table_id = "${aws_route_table.private.id}"
  gateway_id="${aws_nat_gateway.gw.id}"
  destination_cidr_block="0.0.0.0/0"

}


#RouteTableAssociation
resource "aws_route_table_association" "private3_association" {
  route_table_id = "${aws_route_table.private.id}"
  subnet_id = "${aws_subnet.private3.id}"
}
resource "aws_route_table_association" "private4_association" {
  route_table_id = "${aws_route_table.private.id}"
  subnet_id = "${aws_subnet.private4.id}"
}
resource "aws_route_table_association" "public1_association" {
  route_table_id = "${aws_route_table.public.id}"
  subnet_id = "${aws_subnet.public1.id}"
}
resource "aws_route_table_association" "public2_association" {
  route_table_id = "${aws_route_table.public.id}"
  subnet_id = "${aws_subnet.public2.id}"
}
