resource "aws_db_instance" "sporter-postgres-db" {
  allocated_storage    = 10
  db_name              = "sporter-postgres-db1"
  engine               = "aurora-postgresql"
  instance_class       = "db.serverless"
  username             = "foo"
  manage_master_user_password = true
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
}

resource "aws_db_subnet_group" "sporter-dbsubnet" {
  name       = "sporter-vpc-dbsubnet-grp"
  subnet_ids = [module.network.subnet1-id, aws_subnet.backend.id]

  tags = {
    Name = "My DB subnet group"
  }
}