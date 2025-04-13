/*
resource "aws_db_instance" "loan_db" {
  identifier            = "loan-database"
  engine               = "mysql"   
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine_version       = "8.0"     
  username            = "admin"
  password            = "password123"   
  publicly_accessible  = true
  skip_final_snapshot  = true

  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

resource "aws_security_group" "rds_sg" {
  name        = "rds-security-group"
  description = "Allow inbound MySQL access"

  ingress {
    from_port   = 3306  
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }
}

*/
