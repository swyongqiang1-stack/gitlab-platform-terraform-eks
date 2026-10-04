resource "aws_subnet" "public" {
  count = 2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet[count.index]
  availability_zone = var.AZ[count.index]
  tags = {
    Component = "network"
    Name = "public-subnet-${count.index}"
  }
}


resource "aws_route_table" "public" {
  count = 2
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.public_subnet[count.index]
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table-${count.index}"
    Component = "route-table"
  }
}

resource "aws_route_table_association" "public" {
  count = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}


resource "aws_subnet" "private" {
  count = 2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet[count.index]
  availability_zone = var.AZ[count.index]
  tags = {
    Component = "network"
    Name = "private-subnet-${count.index}"
  }
}


resource "aws_route_table" "private" {
  count = 2
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.private_subnet[count.index]
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "private-route-table-${count.index}"
    Component = "route-table"
  }
}

resource "aws_route_table_association" "private" {
  count = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}


