aws_region = "ap-northeast-2"

region_prefix = "apn2"

cidr_numeral = "10"

environment = "prod"

availability_zones = ["ap-northeast-2a", "ap-northeast-2b"]

my_ip = "0.0.0.0/0"

# lb 주입 변수
service_port = 8000

# common 주입 변수
root_domain_name = "til-challenge.com"

alb_record_name = "kr.til-challenge.com"

# iam 주입 변수
ssm_prefix = "team9900"


# database 주입 변수
cache_instance_type = "cache.t3.micro"

opensearch_instance_type = "t3.small.search"
opensearch_username      = "admin"
opensearch_password      = "#Rhwlsgur123"

user_db_instance_type = "db.t3.micro"
user_db_name          = "users"
user_db_username      = "root"
user_db_password      = "#Rhwlsgur123"

resv_db_instance_type = "db.t3.medium"
resv_db_name          = "reservations"
resv_db_username      = "root"
resv_db_password      = "#Rhwlsgur123"

# config 주입 변수
ses_emails = [
  "hyeok1234565@gmail.com",
  "hyeok0476@naver.com"
]

ssm_parameters = {
  "AWS_SES_SENDER" : "hyeok0476@naver.com",
  "JWT_ACCESS_EXPIRE_TIME" : "1800000",
  "JWT_REFRESH_EXPIRE_TIME" : "2592000000",
  "JWT_SECRET_KEY" : "bsfi130rbo1092bkjV9h31hbJENq0e9wvnLszss9012hbe2i1oIf9hsdsbOSHq92onf",
  "JWT_SIGNUP_SECRET_KEY" : "obq3n20naosDNONwqPId801qBfnaDOqaQdipqnRasodvnq91bGoenWOElqlDifd",
  "USER_SERVICE_URI" : "http://user-api.service-connect.local:8081",
  "NOTIFICATION_SERVICE_URI" : "http://notification-api.service-connect.local:8082",
  "SEARCH_SERVICE_URI" : "http://search-api.service-connect.local:8083",
  "RESERVATION_SERVICE_URI" : "http://reservation-api.service-connect.local:8084",
  "OPENSEARCH_INDEX" : "restaurants",
}

# bastion 주입 변수
bastion_instance_type = "t3.micro"

public_key_path = "bastion_ssh_key/prod-apn2-bastion-key.pub"

# ecs 주입 변수(task, service)
services = {
  user_service = {
    container_name        = "prod-apn2-user-container"
    service_name          = "prod-apn2-user-service"
    container_port        = 8081
    ecs_cpu               = 2048
    ecs_memory            = 4096
    enable_alb            = false
    family                = "prod-apn2-user-service-task"
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
    container_name        = "prod-apn2-notification-container"
    service_name          = "prod-apn2-notification-service"
    container_port        = 8082
    ecs_cpu               = 2048
    ecs_memory            = 4096
    enable_alb            = false
    family                = "prod-apn2-notification-service-task"
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
    container_name        = "prod-apn2-search-container"
    service_name          = "prod-apn2-search-service"
    container_port        = 8083
    ecs_cpu               = 2048
    ecs_memory            = 4096
    enable_alb            = false
    family                = "prod-apn2-search-service-task"
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
    container_name        = "prod-apn2-reservation-container"
    service_name          = "prod-apn2-reservation-service"
    container_port        = 8084
    ecs_cpu               = 2048
    ecs_memory            = 4096
    enable_alb            = false
    family                = "prod-apn2-reservation-service-task"
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
  container_name        = "prod-apn2-auth-container"
  service_name          = "prod-apn2-auth-service"
  container_port        = 8000
  ecs_cpu               = 2048
  ecs_memory            = 4096
  enable_alb            = true
  family                = "prod-apn2-auth-service-task"
  host_port             = 8000
  image_uri             = "hyeok1234565/authorization-service:iac"
  log_index             = "ecs_logs_auth_svc"
  log_port              = 443
  port_name             = "auth-port"
  dns_name              = "auth-api.service-connect.local"
  discovery_name        = "auth-api"
  service_desired_count = 2
}
