########################################
# Outputs
########################################

output "id" {
  description = "The name of the table"
  value       = aws_dynamodb_table.this.id
}

output "arn" {
  description = "The arn of the table"
  value       = aws_dynamodb_table.this.arn
}
output "debug_read_capacity" {
  value = var.read_capacity
}

output "debug_write_capacity" {
  value = var.write_capacity
}
