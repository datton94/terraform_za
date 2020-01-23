resource "aws_kms_key" "a" {
  description             = "KMS key 1"
  deletion_window_in_days = 15
}

resource "aws_kms_ciphertext" "mydb_password" {
  key_id    = aws_kms_key.a.key_id
  plaintext = random_password.password.result
}

resource "aws_ssm_parameter" "mydb_password" {
  name        = "mydb_password"
  description = "Encryted database password"
  type        = "SecureString"
  value       = aws_kms_ciphertext.mydb_password.ciphertext_blob
}
