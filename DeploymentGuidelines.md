# Deployment Guidelines for S3 Static Website using CloudFormation

## Introduction
The following document explains the steps to deploy a S3 Static Website using CloudFormation.

## Prerequisites
* AWS CLI installed and configured with access keys
* Basic knowledge of CloudFormation

## Steps

1. Clone the Git repository to your local machine.
2. Navigate to the `cloudformation` directory in the terminal.
3. Modify the variables `CERT`, `HostedZoneResourceID`, and `DomainName` in the Makefile to appropriate values. 
4. Run the following command in the terminal to create the stack:
```make create-stack```
5. To update the existing stack with any changes made to the CloudFormation template file, run the following command in the terminal:
```make update-stack```
6. To delete the stack, run the following command in the terminal:
```make delete-stack```

## Conclusion
By following these simple steps, you can easily deploy an S3 Static Website using CloudFormation. If you encounter any issues or errors during the deployment process, please refer to the AWS documentation.