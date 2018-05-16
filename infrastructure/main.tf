# Modified work: Copyright (c) 2018 Board of Trustees University of Illinois

# This configuration has been modified from the Lambda Service Skeleton project
# found at https://github.com/mokio8/lambda.service.skeleton.git
# See THIRD-PARTY-NOTICES.md for original license information.

module "lambda" {
  source                = "./lambda"
  app_name              = "${var.app_name}"
  region                = "${var.region}"
  credentials_file      = "${var.credentials_file}"
  profile_name          = "${var.profile_name}"
  subnet_a_name         = "${var.subnet_a_name}"
  subnet_b_name         = "${var.subnet_b_name}"
  security_group_name   = "${var.security_group_name}"
  vpc_name              = "${var.vpc_name}"
  lambda_func_name      = "${var.lambda_func_name}"
  lambda_func_desc      = "${var.lambda_func_desc}"
  lambda_func_payload   = "${var.lambda_func_payload}"
  lambda_func_timeout   = "${var.lambda_func_timeout}"
  lambda_func_handler   = "${var.lambda_func_handler}"
  lambda_alexa_skill_id = "${var.lambda_alexa_skill_id}"
}
