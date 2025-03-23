resource "aws_secretsmanager_secret" "secrets" {
  name = "credentials_v2"
}

resource "aws_secretsmanager_secret_version" "secret_version" {
  secret_id     = aws_secretsmanager_secret.secrets.id
  secret_string = jsonencode(var.password)
}


