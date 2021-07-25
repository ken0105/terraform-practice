module "http_sg" {
  source = "./sg"
  name = "http-sg"
  vpc_id = aws_vpc.example.id
  port = 80
  cidr_blocks = ["0.0.0.0/0"]
}

module "https_sg" {
  source = "./sg"
  name = "https_sg"
  vpc_id = aws_vpc.example.id
  port = 443
  cidr_blocks = ["0.0.0.0/0"]
}

module "http_redirect_sg"{
  source = "./sg"
  name = "http_redirect_sg"
  vpc_id = aws_vpc.example.id
  port = 8080
  cidr_blocks = ["0.0.0.0/0"]
}

module "rds_sg" {
  source = "./sg"
  name = "rds_sg"
  vpc_id = aws_vpc.example.id
  port = 5432
  cidr_blocks = [aws_vpc.example.cidr_block]
}