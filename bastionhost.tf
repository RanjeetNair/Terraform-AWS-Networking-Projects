resource "aws_instance" "bastionhost" {
  ami              = "${var.bastionhost_ami}"
  instance_type   = "${var.bastion_instancetype}"
  subnet_id       = "${aws_subnet.public1.id}"
  key_name = "ranjeet.nair-iit"
  associate_public_ip_address = true

  vpc_security_group_ids = [
    "${aws_security_group.bastion.id}"
  ]
  tags            = {
    Name        = "bastionhost"

  }



}