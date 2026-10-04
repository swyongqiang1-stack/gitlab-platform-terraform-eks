resource "aws_eip" "nat" {
  count = 2
  domain   = aws_vpc.main.id
  depends_on = aws_internet_gateway.igw
  region = var.region
  tags = {
    Name = "eip-nat-${count.index}"
    Component = "network"
  }
}

resource "aws_nat_gateway" "main" {
  count = 2
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = "NAT-${count.index}"
    command = "network"
  }

  depends_on = [
    aws_internet_gateway.igw,
    aws_eip.nat
  ]
}
