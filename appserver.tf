
resource "aws_instance" "appserver_1" {
  ami              = "${var.appserver_ami}"
  instance_type   = "${var.appserver_instancetype}"
  subnet_id       = "${aws_subnet.private3.id}"
  private_ip      = "${var.appserver_ip}"
  key_name = "ranjeet.nair-iit"

  vpc_security_group_ids = [
    "${aws_security_group.appserver.id}"
  ]
  tags            = {
    Name        = "appserver_1"

  }



}