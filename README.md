# AWS CloudFormation Resource Documentation

This CloudFormation template creates a static website hosting infrastructure using AWS S3 and CloudFront with a custom domain. It sets up the necessary resources, such as S3 bucket, CloudFront distribution, Route 53 DNS record, and IAM user, to enable hosting a static website securely.

## Template Information

- **AWSTemplateFormatVersion:** 2010-09-09
- **Description:** Static website hosting with S3 and CloudFront with a custom domain.

## Parameters

1. **Cert** (String):
   - Description: SSL Certificate ARN
   - Type: String

2. **HostedZoneResourceID** (String):
   - Description: Hosted Zone ID
   - Type: String

3. **DomainName** (String):
   - Description: Website Domain Name
   - Type: String

4. **ErrorPagePath** (String):
   - Description: Directory error path
   - Type: String
   - Default: /error.html

5. **IndexDocument** (String):
   - Description: Directory index path
   - Type: String
   - Default: /index.html

## Resources

### S3Bucket

- **Type:** AWS::S3::Bucket
- **Properties:**
  - **BucketName:** `${DomainName}-cloudfront`

### CloudFrontOriginAccessIdentity

- **Type:** AWS::CloudFront::CloudFrontOriginAccessIdentity
- **Properties:**
  - **CloudFrontOriginAccessIdentityConfig:**
    - **Comment:** `!Ref S3Bucket`

### ReadPolicy

- **Type:** AWS::S3::BucketPolicy
- **Properties:**
  - **Bucket:** `!Ref S3Bucket`
  - **PolicyDocument:**
    - **Statement:**
      - **Action:** s3:GetObject
      - **Effect:** Allow
      - **Resource:** `${S3Bucket.Arn}`, `${S3Bucket.Arn}/*`
      - **Principal:**
        - **CanonicalUser:** `!GetAtt CloudFrontOriginAccessIdentity.S3CanonicalUserId`

### CloudFrontDistribution

- **Type:** AWS::CloudFront::Distribution
- **Properties:**
  - **DistributionConfig:**
    - **Aliases:** `!Ref DomainName`
    - **ViewerCertificate:**
      - **AcmCertificateArn:** `!Ref Cert`
      - **SslSupportMethod:** sni-only
    - **CustomErrorResponses:**
      - **ErrorCode:** 403
      - **ResponseCode:** 404
      - **ResponsePagePath:** `!Ref ErrorPagePath`
    - **DefaultCacheBehavior:**
      - **AllowedMethods:** GET, HEAD, OPTIONS
      - **CachedMethods:** GET, HEAD, OPTIONS
      - **Compress:** true
      - **DefaultTTL:** 3600
      - **ForwardedValues:**
        - **Cookies:** Forward: none
        - **QueryString:** false
      - **MaxTTL:** 86400
      - **MinTTL:** 60
      - **TargetOriginId:** s3origin
      - **ViewerProtocolPolicy:** redirect-to-https
    - **DefaultRootObject:** index.html
    - **Enabled:** true
    - **HttpVersion:** http2
    - **Origins:**
      - **DomainName:** `!GetAtt S3Bucket.DomainName`
        - **Id:** s3origin
        - **S3OriginConfig:**
          - **OriginAccessIdentity:** `!Sub origin-access-identity/cloudfront/${CloudFrontOriginAccessIdentity}`
    - **PriceClass:** PriceClass_All

### PublishUser

- **Type:** AWS::IAM::User
- **Properties:**
  - **Policies:**
    - **PolicyName:** `!Sub "publish-to-${S3Bucket}"`
    - **PolicyDocument:**
      - **Statement:**
        - **Action:** s3:*
        - **Effect:** Allow
        - **Resource:** `${S3Bucket.Arn}`, `${S3Bucket.Arn}/*`

### DNSRecord

- **Type:** AWS::Route53::RecordSet
- **Properties:**
  - **HostedZoneId:** `!Ref HostedZoneResourceID`
  - **Comment:** DNS name for cloud front
  - **Name:** `!Ref DomainName`
  - **Type:** A
  - **AliasTarget:**
    - **HostedZoneId:** Z2FDTNDATAQYW2
    - **DNSName:** `!GetAtt CloudFrontDistribution.DomainName`
  - **DependsOn:** CloudFrontDistribution

## Outputs

- **BucketName:**
  - **Description:** S3 Bucket Name
  - **Value:** `!Ref S3Bucket`

- **PublishUser:**
  - **Description:** IAM User with write access to the bucket
  - **Value:** `!Ref PublishUser`

- **URL:**
  - **Description:** Website URL
  - **Value:** `!Ref DNSRecord`

  <!-- ACM ARN
  arn:aws:acm:us-east-1:969247091925:certificate/f93ea9ca-bf8c-4ac2-bd95-194cfe072ecf -->
