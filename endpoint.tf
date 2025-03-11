resource "aws_dms_endpoint" "source" {
  database_name = "var.env{database_name}"
  endpoint_id   = "${var.environment}-source-endpoint"
  endpoint_type = "source"
  engine_name   = "mariadb"
  engine_name   = "aurora-postgresql"
  username      = data.terraform_remote_state.rds.outputs.postgres_rds_user_name
  password      = data.terraform_remote_state.rds.outputs.postgres_rds_password
  port          = data.terraform_remote_state.rds.outputs.postgres_port_new
  database_name               = "var.env{database_name}"
  endpoint_id                 = "${var.environment}-target-endpoint"
  endpoint_type               = "target"
  engine_name                 = "mariadb"
  engine_name                 = "aurora-postgresql"
  username                    = data.terraform_remote_state.rds.outputs.postgres_rds_user_name_new
  password                    = data.terraform_remote_state.rds.outputs.postgres_rds_password_new
  port                        = data.terraform_remote_state.rds.outputs.postgres_port_new
  server_name                 = data.terraform_remote_state.rds.outputs.postgres_rds_cluster_endpoint_new
  ssl_mode                    = "none"
  tags = {
    Name = "${var.environment}-target-endpoint"
  }
}

# resource "aws_dms_replication_task" "aws_dms_replication_task" {
#   for_each                  = local.endpoints
#   migration_type            = "full-load-and-cdc"
#   replication_instance_arn  = aws_dms_replication_instance.aws_dms_replication_instance.replication_instance_arn
#   replication_task_id       = "${var.environment}-${each.key}-migration-task"
#   replication_task_settings = file("task_settings.json")
#   source_endpoint_arn       = aws_dms_endpoint.source[each.key].endpoint_arn
#   target_endpoint_arn       = aws_dms_endpoint.target[each.key].endpoint_arn
#   table_mappings            = "{\"rules\":[{\"rule-type\":\"selection\",\"rule-id\":\"1\",\"rule-name\":\"1\",\"object-locator\":{\"schema-name\":\"${each.value["database_name"]}\",\"table-name\":\"%\"},\"rule-action\":\"include\"}]}"
#   start_replication_task    = false
#   tags = {
#     Name = "${var.environment}-${each.key}-migration-task"
#   }
#   lifecycle {
#     ignore_changes = [replication_task_settings]
#   }
# }

another commit 

resource "aws_dms_endpoint" "source" {
  database_name = "var.env{database_name}"
  endpoint_id   = "${var.environment}-source-endpoint"
  endpoint_type = "source"
  engine_name   = "aurora-postgresql"
  username      = data.terraform_remote_state.rds.outputs.postgres_rds_user_name
  password      = data.terraform_remote_state.rds.outputs.postgres_rds_password
  port          = data.terraform_remote_state.rds.outputs.postgres_port_new
  server_name   = data.terraform_remote_state.rds.outputs.postgres_rds_cluster_endpoint
  ssl_mode      = "none"
  tags = {
    Name = "${var.environment}-source-endpoint"
  }
}

resource "aws_dms_endpoint" "target" {
  database_name               = "var.env{database_name}"
  endpoint_id                 = "${var.environment}-target-endpoint"
  endpoint_type               = "target"
  engine_name                 = "aurora-postgresql"
  username                    = data.terraform_remote_state.rds.outputs.postgres_rds_user_name_new
  password                    = data.terraform_remote_state.rds.outputs.postgres_rds_password_new
  port                        = data.terraform_remote_state.rds.outputs.postgres_port_new
  server_name                 = data.terraform_remote_state.rds.outputs.postgres_rds_cluster_endpoint_new
  ssl_mode                    = "none"
  tags = {
    Name = "${var.environment}-target-endpoint"
  }
}

# resource "aws_dms_replication_task" "aws_dms_replication_task" {
#   for_each                  = local.endpoints
#   migration_type            = "full-load-and-cdc"
#   replication_instance_arn  = aws_dms_replication_instance.aws_dms_replication_instance.replication_instance_arn
#   replication_task_id       = "${var.environment}-${each.key}-migration-task"
#   replication_task_settings = file("task_settings.json")
#   source_endpoint_arn       = aws_dms_endpoint.source[each.key].endpoint_arn
#   target_endpoint_arn       = aws_dms_endpoint.target[each.key].endpoint_arn
#   table_mappings            = "{\"rules\":[{\"rule-type\":\"selection\",\"rule-id\":\"1\",\"rule-name\":\"1\",\"object-locator\":{\"schema-name\":\"${each.value["database_name"]}\",\"table-name\":\"%\"},\"rule-action\":\"include\"}]}"
#   start_replication_task    = false
#   tags = {
#     Name = "${var.environment}-${each.key}-migration-task"
#   }
#   lifecycle {
#     ignore_changes = [replication_task_settings]
#   }
# }
resource "aws_dms_replication_task" "aws_dms_replication_task" {
  migration_type            = "full-load-and-cdc"
  replication_instance_arn  = aws_dms_replication_instance.aws_dms_replication_instance.replication_instance_arn
  replication_task_id       = "${var.environment}-var.env{database_name}-migration-task"
  replication_task_settings = file("task_settings.json")
  source_endpoint_arn       = aws_dms_endpoint.source.endpoint_arn
  target_endpoint_arn       = aws_dms_endpoint.target.endpoint_arn
  table_mappings            = "{\"rules\":[{\"rule-type\":\"selection\",\"rule-id\":\"1\",\"rule-name\":\"1\",\"object-locator\":{\"schema-name\":\"account_management\",\"table-name\":\"%\"},\"rule-action\":\"include\"}]}"
  start_replication_task    = false
  tags = {
    Name = "${var.environment}-var.env{database_name}-migration-task"
  }
  lifecycle {
    ignore_changes = [replication_task_settings]
  }
}
