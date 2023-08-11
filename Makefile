#Rename the parameters below as per your requirements
STACK_NAME =example_stack_name
STACK_BODY =file://cloudformation.yaml
CERT =<your_cert_arn>
HostedZoneResourceID =Z08364032UVM9IDKSEQLI
DomainName =<your_domain.com>
Profile =<your_profile_name_in_aws_config> #located at ~/.aws/config by default

create-stack:
	aws cloudformation create-stack --region us-east-1 --stack-name $(STACK_NAME) --template-body $(STACK_BODY) --parameters ParameterKey=Cert,ParameterValue=$(CERT) ParameterKey=HostedZoneResourceID,ParameterValue=$(HostedZoneResourceID) ParameterKey=DomainName,ParameterValue=$(DomainName) --capabilities=CAPABILITY_NAMED_IAM --profile $(Profile)

create-stack:
	aws cloudformation create-stack --region us-east-1 --stack-name $(STACK_NAME) --template-body $(STACK_BODY) --parameters ParameterKey=HostedZoneResourceID,ParameterValue=$(HostedZoneResourceID) ParameterKey=DomainName,ParameterValue=$(DomainName) --capabilities=CAPABILITY_NAMED_IAM --profile $(Profile)

update-stack:
	aws cloudformation update-stack --region us-east-1 --stack-name $(STACK_NAME) --template-body $(STACK_BODY) --parameters ParameterKey=Cert,ParameterValue=$(CERT) ParameterKey=HostedZoneResourceID,ParameterValue=$(HostedZoneResourceID) ParameterKey=DomainName,ParameterValue=$(DomainName) --capabilities=CAPABILITY_NAMED_IAM --profile $(Profile)

delete-stack:
	aws cloudformation delete-stack --region us-east-1 --stack-name $(STACK_NAME) --profile $(Profile)