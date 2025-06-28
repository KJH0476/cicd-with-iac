aws_region = "ap-northeast-2"

region_prefix = "apn2"

cidr_numeral = "10"

environment = "dev"

availability_zones = ["ap-northeast-2a", "ap-northeast-2b"]

my_ip = "0.0.0.0/0"

# lb 주입 변수
service_port = 8000

# common 주입 변수
root_domain_name = "til-challenge.com"

alb_record_name = "dev-kr.til-challenge.com"

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

public_key_path = "bastion_ssh_key/dev-apn2-bastion-key.pub"
