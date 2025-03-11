data "aws_iam_policy_document" "aws_iam_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["dms.amazonaws.com"]
      type        = "Service"
    }
  }
}

resource "aws_iam_role" "dms-cloudwatch-logs-role" {
  assume_role_policy = data.aws_iam_policy_document.aws_iam_policy_document.json
  name               = "dms-cloudwatch-logs-role"
}

resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSCloudWatchLogsRole"
  role       = aws_iam_role.dms-cloudwatch-logs-role.name
}

resource "aws_iam_role" "dms-vpc-role" {
  assume_role_policy = data.aws_iam_policy_document.aws_iam_policy_document.json
  name               = "dms-vpc-role"
}

resource "aws_iam_role_policy_attachment" "aws_iam_role_policy_attachment_vpc" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"
  role       = aws_iam_role.dms-vpc-role.name
}

resource "aws_dms_replication_subnet_group" "aws_dms_replication_subnet_group" {
  replication_subnet_group_description = "${var.environment} replication subnet group"
  replication_subnet_group_id          = "dms-replication-subnet-group-${var.environment}-${data.terraform_remote_state.vpc.outputs.random_id}"
  subnet_ids                           = data.terraform_remote_state.vpc.outputs.db_subnets
  depends_on                           = [aws_iam_role.dms-vpc-role]
}

resource "aws_security_group" "aws_security_group" {
  name   = "${var.environment}-dms-${data.terraform_remote_state.vpc.outputs.random_id}"
  vpc_id = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    from_port   = data.terraform_remote_state.rds.outputs.postgres_port_new
    to_port     = data.terraform_remote_state.rds.outputs.postgres_port_new
    protocol    = "tcp"
    cidr_blocks = data.terraform_remote_state.vpc.outputs.db_subnets_cidr
  }
  
  apply_immediately            = true
  auto_minor_version_upgrade   = true
  availability_zone            = data.terraform_remote_state.vpc.outputs.availability_zone[0]
  engine_version               = "3.5.2"
  engine_version               = "3.5.3"
  multi_az                     = false
  preferred_maintenance_window = "sun:10:30-sun:14:30"
  publicly_accessible          = true
  replication_instance_class   = "dms.t3.medium"
  replication_instance_id      = "${var.environment}-instance"
  replication_subnet_group_id  = aws_dms_replication_subnet_group.aws_dms_replication_subnet_group.id
  vpc_security_group_ids       = [aws_security_group.aws_security_group.id]
  tags = {
    Name = var.environment
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_iam_role.dms-vpc-role, aws_iam_role.dms-cloudwatch-logs-role
  ]
