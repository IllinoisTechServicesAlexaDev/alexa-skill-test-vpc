# Copyright (c) 2018 Board of Trustees University of Illinois

variable "region" {
    description = "AWS region where this lambda will be deployed"
}

variable "profile_name" {
    description = "Name of profile to use within credentials file"
}

variable "credentials_file" {
    description = "Path to credentials file"
}

variable "app_name" {
    description = "Name of this application"
}

variable "subnet_a_name" {
    description = "Subnet A within VPC"
}

variable "subnet_b_name" { 
    description = "Subnet B within VPC"
}

variable "security_group_name" {
    description = "Security group name"
}

variable "vpc_name" {
    description = "VPC name"
}

variable "lambda_func_payload" {
    description = "Path to Lambda function payload package"
}

variable "lambda_func_name" {
    description = "Lambda function name"
}

variable "lambda_func_desc" {
    description = "Lambda function description"
}

variable "lambda_func_handler" {
    description = "Lambda function handler"
}

variable "lambda_func_timeout" {
    description = "Lambda function timeout"
}

variable "lambda_alexa_skill_id" {
    description = "Alexa Skill ID"
}
