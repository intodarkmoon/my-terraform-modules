resource "aws_vpc" "main" {


  cidr_block           = var.cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = {
    Name = "vpc-galang"
  }
}


################################################################################
# Creating Subnets
################################################################################

resource "aws_subnet" "public_subnet" {
  for_each = zipmap(var.azs, var.public_cidr_subnet)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags = {
    Name = "public_subnet-${each.key}"
  }
}

resource "aws_subnet" "private_subnet" {
  for_each = zipmap(var.azs, var.private_cidr_subnet)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = false
  tags = {
    Name = "private_subnet-${each.key}"
  }
}



################################################################################
# Creating Route Tables
################################################################################
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.main.id

}
