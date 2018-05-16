# Modified work: Copyright (c) 2018 Board of Trustees University of Illinois

# This configuration has been modified from the Lambda Service Skeleton project
# found at https://github.com/mokio8/lambda.service.skeleton.git
# See THIRD-PARTY-NOTICES.md for original license information.

variable "app_name" {}
variable "region" {}
variable "profile_name" {}
variable "credentials_file" {}
variable "lambda_func_name" {}
variable "lambda_func_desc" {}
variable "lambda_func_payload" {}
variable "lambda_func_timeout" {}
variable "lambda_func_handler" {}
variable "lambda_alexa_skill_id" {}

provider "aws" {
  region                  = "${var.region}"
  shared_credentials_file = "${var.credentials_file}"
  profile                 = "${var.profile_name}"
}

resource "aws_iam_role_policy" "lambda-invoke" {
  name = "${var.lambda_func_name}-lambda-invoke"
  role = "${aws_iam_role.main.id}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowExecutionFromAlexa",
      "Effect": "Allow",
      "Resource": [
        "*"
      ],
      "Condition": {
        "StringEquals": {
           "lambda:EventSourcetoken": "${var.lambda_alexa_skill_id}"
        }
      },
      "Action": [
        "lambda:InvokeFunction"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role" "main" {
  name = "lambda-${var.lambda_func_name}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": ["lambda.amazonaws.com", "apigateway.amazonaws.com"]
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "main" {
  name = "${var.lambda_func_name}-lambda-policy"
  role = "${aws_iam_role.main.id}"

  policy = <<POLICY
{
    "Version": "2012-10-17",
       "Statement": [
        {
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents",
                "ec2:CreateNetworkInterface",
                "ec2:DescribeNetworkInterfaces",
                "ec2:DeleteNetworkInterface"
            ],
            "Effect": "Allow",
            "Resource": "*"
        }
    ]
}
POLICY
}

resource "aws_lambda_function" "main" {
  filename         = "${var.lambda_func_payload}"
  function_name    = "${var.lambda_func_name}"
  description      = "${var.lambda_func_desc}"
  handler          = "${var.lambda_func_handler}"
  role             = "${aws_iam_role.main.arn}"
  memory_size      = 128
  runtime          = "python2.7"
  timeout          = "${var.lambda_func_timeout}"
  source_code_hash = "${base64sha256(file("${var.lambda_func_payload}"))}"
  vpc_config {
    subnet_ids = [ "${data.aws_subnet.a.id}",
                   "${data.aws_subnet.b.id}" ],
    security_group_ids = [ "${data.aws_security_group.sg.id}" ]
  }
}

resource "aws_lambda_permission" "default" {
  statement_id  = "AllowExecutionFromAlexa"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.main.function_name}"
  principal     = "alexa-appkit.amazon.com"
}

