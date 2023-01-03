output "address" {
	value = aws_db_instance.example.address
	description = "Connect"
}

output "port" {
	value = aws_db_instance.example.port
	description = "port"
}
