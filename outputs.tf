output "json" {
  description = "JSON encoded container definitions array for use with other terraform resources such as aws_ecs_task_definition."
  value = "[${jsonencode(local.container_definition)}]"
}

output "json_map" {
  description = "JSON encoded container definition object for use when you have multiple container definitions to put in a single Task Definition."
  value = "${jsonencode(local.container_definition)}"
}
