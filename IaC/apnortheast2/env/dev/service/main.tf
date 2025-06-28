# core 스택의 output 값을 가져오기 위한 remote state 설정
data "terraform_remote_state" "core" {
  backend = "s3"
  config = {
    bucket = "team9900-terraform-tfstate"
    key    = "apnorthe2/dev/core/terraform.tfstate"
    region = var.aws_region
  }
}

// ECS 서비스 설정을 위한 변수 정의
module "ecs" {
  for_each = var.services
  source   = "../../../../_module/ecs"

  region_prefix       = var.region_prefix
  environment         = var.environment
  app_private_subnets = data.terraform_remote_state.core.outputs.network_private_subnet_ids
  aws_region          = var.aws_region

  container_name          = each.value.container_name
  container_port          = each.value.container_port
  dns_name                = each.value.dns_name
  ecs_cluster_id          = data.terraform_remote_state.core.outputs.common_ecs_cluster_id
  ecs_cpu                 = each.value.ecs_cpu
  ecs_memory              = each.value.ecs_memory
  enable_alb              = each.value.enable_alb
  service_secrets         = local.service_secrets[each.key]
  execution_role_arn      = data.terraform_remote_state.core.outputs.common_ecs_task_execution_role_arn
  family                  = each.value.family
  host_port               = each.value.host_port
  image_uri               = each.value.image_uri
  log_host                = data.terraform_remote_state.core.outputs.database_opensearch_domain_endpoint
  log_index               = each.value.log_index
  log_port                = each.value.log_port
  namespace               = data.terraform_remote_state.core.outputs.common_ecs_cluster_namespace
  port_name               = each.value.port_name
  service_name            = each.value.service_name
  discovery_name          = each.value.discovery_name
  service_desired_count   = each.value.service_desired_count
  service_security_groups = [local.service_security_groups[each.key]]
  task_role_arn           = local.service_task_roles[each.key]
  lb_target_group_arn     = data.terraform_remote_state.core.outputs.load_balancer_app_external_tg_arn
}

# 서비스 커넥트 설정을 위해 authorization-service 를 가장 마지막에 생성
module "ecs_auth_service" {
  source = "../../../../_module/ecs"

  region_prefix       = var.region_prefix
  environment         = var.environment
  app_private_subnets = data.terraform_remote_state.core.outputs.network_private_subnet_ids
  aws_region          = var.aws_region

  container_name          = var.authorization_service_config.container_name
  container_port          = var.authorization_service_config.container_port
  dns_name                = var.authorization_service_config.dns_name
  ecs_cluster_id          = data.terraform_remote_state.core.outputs.common_ecs_cluster_id
  ecs_cpu                 = var.authorization_service_config.ecs_cpu
  ecs_memory              = var.authorization_service_config.ecs_memory
  enable_alb              = var.authorization_service_config.enable_alb
  service_secrets         = local.service_secrets["authorization_service"]
  execution_role_arn      = data.terraform_remote_state.core.outputs.common_ecs_task_execution_role_arn
  family                  = var.authorization_service_config.family
  host_port               = var.authorization_service_config.host_port
  image_uri               = var.authorization_service_config.image_uri
  log_host                = data.terraform_remote_state.core.outputs.database_opensearch_domain_endpoint
  log_index               = var.authorization_service_config.log_index
  log_port                = var.authorization_service_config.log_port
  namespace               = data.terraform_remote_state.core.outputs.common_ecs_cluster_namespace
  port_name               = var.authorization_service_config.port_name
  service_name            = var.authorization_service_config.service_name
  discovery_name          = var.authorization_service_config.discovery_name
  service_desired_count   = var.authorization_service_config.service_desired_count
  service_security_groups = [local.service_security_groups["authorization_service"]]
  task_role_arn           = local.service_task_roles["authorization_service"]
  lb_target_group_arn     = data.terraform_remote_state.core.outputs.load_balancer_app_external_tg_arn

  depends_on = [module.ecs]
}

# 로컬 변수 정의
locals {
  service_security_groups = {
    authorization_service = data.terraform_remote_state.core.outputs.ecs_auth_sg_id
    user_service          = data.terraform_remote_state.core.outputs.ecs_user_sg_id
    search_service        = data.terraform_remote_state.core.outputs.ecs_search_sg_id
    notification_service  = data.terraform_remote_state.core.outputs.ecs_noti_sg_id
    reservation_service   = data.terraform_remote_state.core.outputs.ecs_resv_sg_id
  }

  service_task_roles = {
    authorization_service = data.terraform_remote_state.core.outputs.iam_ecs_task_role_arn
    user_service          = data.terraform_remote_state.core.outputs.iam_ecs_task_role_arn
    search_service        = data.terraform_remote_state.core.outputs.iam_ecs_task_role_arn
    notification_service  = data.terraform_remote_state.core.outputs.iam_notification_task_role_arn
    reservation_service   = data.terraform_remote_state.core.outputs.iam_ecs_task_role_arn
  }

  service_secrets = {
    authorization_service = {
      JWT_SECRET_KEY          = data.terraform_remote_state.core.outputs.ssm_parameter_arns["JWT_SECRET_KEY"]
      JWT_ACCESS_EXPIRE_TIME  = data.terraform_remote_state.core.outputs.ssm_parameter_arns["JWT_ACCESS_EXPIRE_TIME"]
      JWT_REFRESH_EXPIRE_TIME = data.terraform_remote_state.core.outputs.ssm_parameter_arns["JWT_REFRESH_EXPIRE_TIME"]
      REDIS_HOST              = data.terraform_remote_state.core.outputs.ssm_parameter_arns["REDIS_HOST"]
      REDIS_PORT              = data.terraform_remote_state.core.outputs.ssm_parameter_arns["REDIS_PORT"]
      USER_SERVICE_URI        = data.terraform_remote_state.core.outputs.ssm_parameter_arns["USER_SERVICE_URI"]
      SEARCH_SERVICE_URI      = data.terraform_remote_state.core.outputs.ssm_parameter_arns["SEARCH_SERVICE_URI"]
      RESERVATION_SERVICE_URI = data.terraform_remote_state.core.outputs.ssm_parameter_arns["RESERVATION_SERVICE_URI"]
    }
    user_service = {
      JWT_SECRET_KEY          = data.terraform_remote_state.core.outputs.ssm_parameter_arns["JWT_SECRET_KEY"]
      JWT_SIGNUP_SECRET_KEY   = data.terraform_remote_state.core.outputs.ssm_parameter_arns["JWT_SIGNUP_SECRET_KEY"]
      JWT_ACCESS_EXPIRE_TIME  = data.terraform_remote_state.core.outputs.ssm_parameter_arns["JWT_ACCESS_EXPIRE_TIME"]
      JWT_REFRESH_EXPIRE_TIME = data.terraform_remote_state.core.outputs.ssm_parameter_arns["JWT_REFRESH_EXPIRE_TIME"]
      USER_DATABASE_URL       = data.terraform_remote_state.core.outputs.ssm_parameter_arns["USER_DATABASE_URL"]
      USER_DATABASE_USERNAME  = data.terraform_remote_state.core.outputs.ssm_parameter_arns["USER_DATABASE_USERNAME"]
      USER_DATABASE_PASSWORD  = data.terraform_remote_state.core.outputs.ssm_parameter_arns["USER_DATABASE_PASSWORD"]
      REDIS_HOST              = data.terraform_remote_state.core.outputs.ssm_parameter_arns["REDIS_HOST"]
      REDIS_PORT              = data.terraform_remote_state.core.outputs.ssm_parameter_arns["REDIS_PORT"]
    }
    notification_service = {
      AWS_SES_SENDER = data.terraform_remote_state.core.outputs.ssm_parameter_arns["AWS_SES_SENDER"]
    }
    search_service = {
      OPENSEARCH_INDEX  = data.terraform_remote_state.core.outputs.ssm_parameter_arns["OPENSEARCH_INDEX"]
      OPENSEARCH_HOST   = data.terraform_remote_state.core.outputs.ssm_parameter_arns["OPENSEARCH_HOST"]
      OPENSEARCH_REGION = data.terraform_remote_state.core.outputs.ssm_parameter_arns["OPENSEARCH_REGION"]
    }
    reservation_service = {
      NOTIFICATION_SERVICE_URI      = data.terraform_remote_state.core.outputs.ssm_parameter_arns["NOTIFICATION_SERVICE_URI"]
      RESERVATION_DATABASE_URL      = data.terraform_remote_state.core.outputs.ssm_parameter_arns["RESERVATION_DATABASE_URL"]
      RESERVATION_DATABASE_USERNAME = data.terraform_remote_state.core.outputs.ssm_parameter_arns["RESERVATION_DATABASE_USERNAME"]
      RESERVATION_DATABASE_PASSWORD = data.terraform_remote_state.core.outputs.ssm_parameter_arns["RESERVATION_DATABASE_PASSWORD"]
    }
  }
}