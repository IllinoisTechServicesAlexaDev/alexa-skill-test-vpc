# Copyright (c) 2018 Board of Trustees University of Illinois

variable "subnet_a_name" {}
variable "subnet_b_name" {}
variable "security_group_name" {}
variable "vpc_name" {}

data "aws_vpc" "selected" {
  filter {
    name = "tag:Name"
    values = [ "${var.vpc_name}" ]
  }
}

data "aws_subnet" "a" {
  filter {
    name = "tag:Name"
    values = [ "${var.subnet_a_name}" ]
  }
  vpc_id = "${data.aws_vpc.selected.id}"
}

data "aws_subnet" "b" {
  filter {
    name = "tag:Name"
    values = [ "${var.subnet_b_name}" ]
  }
  vpc_id = "${data.aws_vpc.selected.id}"
}

data "aws_security_group" "sg" {
  name = "${var.security_group_name}"
  vpc_id = "${data.aws_vpc.selected.id}"
}

