resource "aws_iam_user" "sporter" {
  name          = "sporter"
  path          = "/"
  force_destroy = true

  tags = {
    terraform = "managed"
  }
}

resource "aws_iam_user_login_profile" "sp-profile" {
  user    = aws_iam_user.sporter.name
  #pgp_key = "keybase:some_person_that_exists"
}

output "password" {
  value = aws_iam_user_login_profile.sp-profile.encrypted_password
}