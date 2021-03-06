resource "aws_nat_gateway" "private_gw" {
  count = "${length(var.aws_azs)}"

  allocation_id = "${element(aws_eip.gateways.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  depends_on = ["aws_internet_gateway.gateway"]
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.vpc_name} IGW"
  }
}

resource "aws_eip" "gateways" {
  count = "${length(var.aws_azs)}"
  vpc   = true
}
