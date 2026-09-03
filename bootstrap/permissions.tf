data "aws_iam_policy_document" "gha_apply_permissions" {
  statement {
    sid    = "ECRPushPull"
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:CreateRepository",
      "ecr:DescribeRepositories"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "ECSManage"
    effect = "Allow"
    actions = [
      "ecs:CreateCluster",
      "ecs:DescribeClusters",
      "ecs:RegisterTaskDefinition",
      "ecs:DescribeTaskDefinition",
      "ecs:CreateService",
      "ecs:UpdateService",
      "ecs:DescribeServices",
      "ecs:ListTasks",
      "ecs:DescribeTasks"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "SupportingServices"
    effect = "Allow"
    actions = [
      "sns:CreateTopic",
      "sns:GetTopicAttributes",
      "sns:Subscribe",
      "lambda:CreateFunction",
      "lambda:GetFunction",
      "lambda:UpdateFunctionCode",
      "lambda:AddPermission",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:DescribeAlarms",
      "iam:PassRole",
      "iam:GetRole",
      "iam:CreateRole",
      "iam:AttachRolePolicy"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "gha_apply_permissions" {
  name   = "gha-apply-permissions"
  role   = aws_iam_role.gha_apply.id
  policy = data.aws_iam_policy_document.gha_apply_permissions.json
}