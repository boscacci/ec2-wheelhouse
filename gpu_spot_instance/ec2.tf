resource "aws_key_pair" "ssh_key" {
  key_name   = "ssh_key"
  public_key = file(var.ssh_pub_path)
}

resource "aws_spot_instance_request" "vps" {
  ami                    = var.instance_ami
  spot_price             = var.spot_price
  instance_type          = var.instance_type
  spot_type              = var.spot_type
  wait_for_fulfillment   = "true"
  key_name               = aws_key_pair.ssh_key.key_name
  count                  = var.spot_instance == "true" ? 1 : 0
  security_groups = ["${aws_security_group.ingress-ssh-vps.id}", "${aws_security_group.ingress-http-vps.id}",
  "${aws_security_group.ingress-https-vps.id}"]
  subnet_id = aws_subnet.subnet-uno.id
  root_block_device {
    volume_size = 96
    volume_type = "gp3"
  }
}

resource "aws_instance" "web" {
  ami                         = var.instance_ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.ssh_key.key_name
  subnet_id                   = aws_subnet.subnet-uno.id
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.ingress-ssh-vps.id}", "${aws_security_group.ingress-http-vps.id}",
  "${aws_security_group.ingress-https-vps.id}"]
  count = var.spot_instance == "true" ? 0 : 1
}

resource "aws_eip" "ip-vps-env" {
  instance = var.spot_instance == "true" ? "${aws_spot_instance_request.vps[0].spot_instance_id}" : "${aws_instance.web[0].id}"
  vpc      = true
  depends_on = [
    aws_spot_instance_request.vps,
  ]
}