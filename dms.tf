#resource "aws_dms_endpoint" "source" {
#   database_name = each.value["database_name"]
#   endpoint_id   = "${var.environment}-source-${each.key}-endpoint"
#   endpoint_type = "source"
#   engine_name   = "mariadb"
#   username      = each.value["aws_dms_endpoint_source_user"]
#   password      = each.value["aws_dms_endpoint_source_password"]
#   port          = 3306
#   server_name   = each.value["aws_dms_endpoint_source_url"]
#   ssl_mode      = "none"
#   tags = {
#     Name = "${var.environment}-source-${each.key}-endpoint"
#   }
# }
# 
# resource "aws_dms_endpoint" "target" {
#   database_name               = each.value["database_name"]
#   endpoint_id                 = "${var.environment}-target-${each.key}-endpoint"
#   endpoint_type               = "target"
#   engine_name                 = "mariadb"
#   username                    = each.value["aws_dms_endpoint_target_user"]
#   password                    = each.value["aws_dms_endpoint_target_password"]
#   port                        = 3306
#   server_name                 = each.value["aws_dms_endpoint_target_url"]
#   ssl_mode                    = "none"
#   extra_connection_attributes = "initstmt=SET FOREIGN_KEY_CHECKS=0"
#   tags = {
#     Name = "${var.environment}-target-${each.key}-endpoint"
#   }
# }

resource "aws_dms_endpoint" "source" {
  database_name = "account_management"
  endpoint_id   = "${var.environment}-source-endpoint"
  endpoint_type = "source"
  engine_name   = "mariadb"
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
  database_name               = "account_management"
  endpoint_id                 = "${var.environment}-target-endpoint"
  endpoint_type               = "target"
  engine_name                 = "mariadb"
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
