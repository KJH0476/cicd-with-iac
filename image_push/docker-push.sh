#!/bin/bash

# Authorization Service 빌드 및 푸시
docker build -t hyeok1234565/authorization-service:iac --platform linux/amd64 ../services/AuthorizationService
docker push hyeok1234565/authorization-service:iac

# User Service 빌드 및 푸시
docker build -t hyeok1234565/user-service:iac --platform linux/amd64 ../services/UserService
docker push hyeok1234565/user-service:iac

# Notification Service 빌드 및 푸시
docker build -t hyeok1234565/notification-service:iac --platform linux/amd64 ../services/NotificationService
docker push hyeok1234565/notification-service:iac

# Search Service 빌드 및 푸시
docker build -t hyeok1234565/search-service:iac --platform linux/amd64 ../services/SearchService
docker push hyeok1234565/search-service:iac

# Reservation Service 빌드 및 푸시
docker build -t hyeok1234565/reservation-service:iac --platform linux/amd64 ../services/ReservationService
docker push hyeok1234565/reservation-service:iac
