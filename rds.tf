resource "aws_rds_cluster_parameter_group" "cluster_parameter_example" {
  name = "example"
  family = "aurora-postgresql10"

  parameter {
    name = "shared_preload_libraries"
    value = "pg_stat_statements ,pg_hint_plan ,pgaudit"
    apply_method = "pending-reboot"
  }
}

resource "aws_db_parameter_group" "instance_parameter_example" {
  name   = "example"
  family = "aurora-postgresql10"
}

resource "aws_db_subnet_group" "example" {
  name = "example"
  subnet_ids = [aws_subnet.private_0.id, aws_subnet.private_1.id]
}

resource "aws_rds_cluster" "cluster_example" {
  cluster_identifier = "example"
  engine = "aurora-postgresql"
  engine_version = "10.14"
  engine_mode = "serverless"
  database_name = "test"
  master_username = "hoge"
  master_password = "dummydummy"
  storage_encrypted = true

  # network
  db_subnet_group_name = aws_db_subnet_group.example.name
  vpc_security_group_ids = [module.rds_sg.security_group_id]
  port = 5432

  backup_retention_period = 1
  copy_tags_to_snapshot = true
  deletion_protection = false
  skip_final_snapshot = true
  final_snapshot_identifier = "example"

  # monitoring
//  enabled_cloudwatch_logs_exports = ["postgresql"]

  # backup window
  preferred_backup_window = "02:00-02:30"

  # options
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.cluster_parameter_example.name
}

//Instances cannot be added to Aurora Serverless clusters
//resource "aws_rds_cluster_instance" "instance_example" {
//  count = 1
//  identifier = "instance-${count.index+1}"
//  cluster_identifier = aws_rds_cluster.cluster_example.cluster_identifier
//  instance_class = "db.r5.large"
//  engine = "aurora-postgresql"
//  engine_version = "10.14"
//
//  availability_zone = ""
//}