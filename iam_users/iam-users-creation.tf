resource "aws_iam_user" "reader_user" {
  name = "MigrationReader"
  tags = {
    Name = "MigrationReader"
    Team = "Migration"
  }
}

resource "aws_iam_user_policy_attachment" "reader_policy" {
  user       = aws_iam_user.reader_user.name
  policy_arn = var.policy_arn
}
