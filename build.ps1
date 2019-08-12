$bucket_name = $(New-Guid).Guid.ToLower().Replace('-','')

aws s3 ls "s3://${bucket_name}" --profile "development"

if ( $? -eq $false ) {
    aws s3 mb "s3://${bucket_name}" `
    --profile "development" `
    --region "us-west-1"
}

aws cloudformation validate-template `
--template-body file://app.yaml `
--profile "development" `
--region "us-west-1"

aws cloudformation package `
--template-file .\app.yaml `
--s3-bucket "${bucket_name}" `
--output-template-file .\package.yaml `
--profile "development"

aws cloudformation deploy `
--template-file .\package.yaml `
--stack-name "MattProofOfConcept" `
--capabilities CAPABILITY_IAM `
--profile "development" `
--region "us-west-1"