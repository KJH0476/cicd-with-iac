output "ecs_services" {
  value       = { for key, svc in module.ecs : key => svc.ecs_service_name }
  description = "Map of ECS Service Names from the ECS module."
}

output "ecs_auth_service_name" {
  value       = module.ecs_auth_service.ecs_service_name
  description = "ECS Auth Service Name from the ECS Auth Service module."
}