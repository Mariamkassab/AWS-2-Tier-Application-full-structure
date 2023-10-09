resource "aws_iam_user" "cicd-user" {
  name = "cicd-user"
}


resource "aws_iam_user_policy_attachment" "test-attach" {
  user       = aws_iam_user.cicd-user.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}