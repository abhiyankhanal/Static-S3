STACK_NAME =thorotv-static-website
STACK_BODY =file://cloudformation.yaml
# CERT =arn:aws:acm:us-east-1:969247091925:certificate/53a4fddc-1424-4d93-84f9-4518129bdcc6
HostedZoneResourceID =Z08364032UVM9IDKSEQLI
DomainName =your_domain.com
Profile =your_profile_name_in_aws_config #located at ~/.aws/config

## uncomment the below lines in case you are using cloudformation_with_custom_cert.yaml
# create-stack:
# 	aws cloudformation create-stack --region us-east-1 --stack-name $(STACK_NAME) --template-body $(STACK_BODY) --parameters ParameterKey=Cert,ParameterValue=$(CERT) ParameterKey=HostedZoneResourceID,ParameterValue=$(HostedZoneResourceID) ParameterKey=DomainName,ParameterValue=$(DomainName) --capabilities=CAPABILITY_NAMED_IAM --profile $(Profile)

create-stack:
	aws cloudformation create-stack --region us-east-1 --stack-name $(STACK_NAME) --template-body $(STACK_BODY) --parameters ParameterKey=HostedZoneResourceID,ParameterValue=$(HostedZoneResourceID) ParameterKey=DomainName,ParameterValue=$(DomainName) --capabilities=CAPABILITY_NAMED_IAM --profile $(Profile)

## uncomment the below lines in case you are using cloudformation_with_custom_cert.yaml
# update-stack:
# 	aws cloudformation update-stack --region us-east-1 --stack-name $(STACK_NAME) --template-body $(STACK_BODY) --parameters ParameterKey=Cert,ParameterValue=$(CERT) ParameterKey=HostedZoneResourceID,ParameterValue=$(HostedZoneResourceID) ParameterKey=DomainName,ParameterValue=$(DomainName) --capabilities=CAPABILITY_NAMED_IAM --profile $(Profile)
update-stack:
	aws cloudformation update-stack --region us-east-1 --stack-name $(STACK_NAME) --template-body $(STACK_BODY) --parameters ParameterKey=HostedZoneResourceID,ParameterValue=$(HostedZoneResourceID) ParameterKey=DomainName,ParameterValue=$(DomainName) --capabilities=CAPABILITY_NAMED_IAM --profile $(Profile)

delete-stack:
	aws cloudformation delete-stack --region us-east-1 --stack-name $(STACK_NAME) --profile $(Profile)