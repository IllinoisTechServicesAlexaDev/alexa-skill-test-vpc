# Modified work: Copyright (c) 2018 Board of Trustees University of Illinois

# This makefile has been modified from the Lambda Service Skeleton project 
# found at https://github.com/mokio8/lambda.service.skeleton.git
# See THIRD-PARTY-NOTICES.md for original license information.

setup:
	rm -rf venv/
	virtualenv venv/ --no-site-packages
	venv/bin/pip install -r requirements.txt
run:
	. venv/bin/activate; python app/main.py

package: setup
	rm -rf package/ && mkdir -p package/ && mkdir -p payload/
	cp -r venv/lib/python2.7/site-packages/* package/
	cp -r app/ package/
	cp -r helpers/ package/
	cd package; zip -r package.zip . -x \*.git\* \*env\* *.zip
	mv package/package.zip payload/
	cd infrastructure/ && terraform get
	@echo "Done building AWS Lambda package in infrastructure/lambda/package.zip"

deploy_test:
	cd infrastructure/ && terraform plan

deploy:
	cd infrastructure/ && terraform apply

destroy:
	cd infrastructure/ && terraform destroy

init:
	cd infrastructure/ && terraform init
