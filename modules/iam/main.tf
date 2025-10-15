# creating iam role for ec2 
resource "aws_iam_role" "iam_role" {
  name               = "${var.proj_prefix}-iam-role" 
  assume_role_policy = var.assume_role_policy  # JSON policy string
  tags = {
    Name = "${var.proj_prefix}-role"
  }
}

# creating an instance profile for ssm 
resource "aws_iam_instance_profile" "profile" {
  name = "${var.proj_prefix}-profile"
  role = aws_iam_role.iam_role.name
}

# creating policy for the ec2 role 
resource "aws_iam_role_policy" "role_policy" {
  name   = "${var.proj_prefix}-policy"
  role   = aws_iam_role.iam_role.id
  policy = var.role_policy   # JSON policy string
} 

# attaching policies to this role 
# NOTE: pass a full policy ARN (e.g., arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore)
resource "aws_iam_role_policy_attachment" "attachment_policy" {
  for_each = toset(var.policy_attachment)
  role       = aws_iam_role.iam_role.name
  policy_arn = each.value  
}
