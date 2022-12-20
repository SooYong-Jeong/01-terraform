output "number_output" {
  value = var.number_example
}

output "string_output" {
  value = var.string_example
}

output "list_output" {
  value = [ for i in var.list_example : upper(i) ]
}
