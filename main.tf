provider "aws" {
    region = "eu-west-1"  
}

resource "aws_instance" "foo" {
  ami           = "ami-091f18e98bc129c4e" # eu-west-2
  instance_type = "t2.micro"
  tags = {
      Name = "TF-Instance"
  }
}
