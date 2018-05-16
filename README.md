Alexa Skill Test in VPC
=======================

This package provides a skeleton environment for deploying an AWS Lambda 
service using Python 2.7. 

# Prerequisites

## Install Python 2.7 if it is not already installed

## Install virtualenv
* pip install virtualenv

## Install Terraform from terraform.io

# Quick Setup

## Initialize the Python virtualenv environment
* make setup

## Configure terraform variables that are specific to your AWS environment 
* cp infrastructure/terraform.tfvars.sample infrastructure/terraform.tfvars
* vi infrastructure/terraform.tfvars

## Initialize terraform environment
* make init

## Build lambda package
* make package

## Perform dry run of deployment
* make deploy_test

## Deploy Lambda function to AWS
* make deploy


Credits
-------

Most of this skeleton code has been modified from the Lambda Service Skeleton 
project found at https://github.com/mokio8/lambda.service.skeleton.git

Modifications has been made by Phil Winans <pwinans@illinois.edu>.

