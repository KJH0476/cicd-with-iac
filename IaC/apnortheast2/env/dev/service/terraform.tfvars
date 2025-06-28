aws_region = "ap-northeast-2"

region_prefix = "apn2"

environment = "prod"

availability_zones = ["ap-northeast-2a", "ap-northeast-2b"]

# ecs 주입 변수(task, service)
services = {
  user_service = {
    container_name        = "dev-apn2-user-container"
    service_name          = "dev-apn2-user-service"
    container_port        = 8081
    ecs_cpu               = 2048
    ecs_memory            = 4096
    enable_alb            = false
    family                = "dev-apn2-user-service-task"
    host_port             = 8081
    image_uri             = "hyeok1234565/user-service:iac"
    log_index             = "ecs_logs_user_svc"
    log_port              = 443
    port_name             = "user-port"
    dns_name              = "user-api.service-connect.local"
    discovery_name        = "user-api"
    service_desired_count = 2
  }

  notification_service = {
    container_name        = "dev-apn2-notification-container"
    service_name          = "dev-apn2-notification-service"
    container_port        = 8082
    ecs_cpu               = 2048
    ecs_memory            = 4096
    enable_alb            = false
    family                = "dev-apn2-notification-service-task"
    host_port             = 8082
    image_uri             = "hyeok1234565/notification-service:iac"
    log_index             = "ecs_logs_noti_svc"
    log_port              = 443
    port_name             = "notification-port"
    dns_name              = "notification-api.service-connect.local"
    discovery_name        = "notification-api"
    service_desired_count = 2
  }

  search_service = {
    container_name        = "dev-apn2-search-container"
    service_name          = "dev-apn2-search-service"
    container_port        = 8083
    ecs_cpu               = 2048
    ecs_memory            = 4096
    enable_alb            = false
    family                = "dev-apn2-search-service-task"
    host_port             = 8083
    image_uri             = "hyeok1234565/search-service:iac"
    log_index             = "ecs_logs_search_svc"
    log_port              = 443
    port_name             = "search-port"
    dns_name              = "search-api.service-connect.local"
    discovery_name        = "search-api"
    service_desired_count = 2
  }

  reservation_service = {
    container_name        = "dev-apn2-reservation-container"
    service_name          = "dev-apn2-reservation-service"
    container_port        = 8084
    ecs_cpu               = 2048
    ecs_memory            = 4096
    enable_alb            = false
    family                = "dev-apn2-reservation-service-task"
    host_port             = 8084
    image_uri             = "hyeok1234565/reservation-service:iac"
    log_index             = "ecs_logs_resv_svc"
    log_port              = 443
    port_name             = "reservation-port"
    dns_name              = "reservation-api.service-connect.local"
    discovery_name        = "reservation-api"
    service_desired_count = 2
  }
}

authorization_service_config = {
  container_name        = "dev-apn2-auth-container"
  service_name          = "dev-apn2-auth-service"
  container_port        = 8000
  ecs_cpu               = 2048
  ecs_memory            = 4096
  enable_alb            = true
  family                = "dev-apn2-auth-service-task"
  host_port             = 8000
  image_uri = "471112983866.dkr.ecr.ap-northeast-2.amazonaws.com/dev-apn2-ecr-repo:authorization_service-20250628-095348"
  log_index             = "ecs_logs_auth_svc"
  log_port              = 443
  port_name             = "auth-port"
  dns_name              = "auth-api.service-connect.local"
  discovery_name        = "auth-api"
  service_desired_count = 2
}
