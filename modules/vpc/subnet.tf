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
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "public-route-table-${count.index}"
    Component = "network"
  }
}

resource "aws_route_table_association" "public" {
  count = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[count.index].id
}




#--------app
resource "aws_subnet" "private_app" {
  count = 2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_app[count.index]
  availability_zone = var.AZ[count.index]
  tags = {
    Component = "network"
    Name = "private-subnet-app-${count.index}"
  }
}


resource "aws_route_table" "private_app" {
  count = 2
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main[count.index].id
  }

  tags = {
    Name = "private-route-table-app-${count.index}"
    Component = "network"
  }
}

resource "aws_route_table_association" "private_app" {
  count = 2
  subnet_id      = aws_subnet.private_app[count.index].id
  route_table_id = aws_route_table.private_app[count.index].id
}



#--------database
resource "aws_subnet" "private_db" {
  count = 2
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_db[count.index]
  availability_zone = var.AZ[count.index]
  tags = {
    Component = "network"
    Name = "private-subnet-db-${count.index}"
  }
}


resource "aws_route_table" "private_db" {
  count = 2
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-route-table-db-${count.index}"
    Component = "network"
  }
}

resource "aws_route_table_association" "private_db" {
  count = 2
  subnet_id      = aws_subnet.private_db[count.index].id
  route_table_id = aws_route_table.private_db[count.index].id
}


