aws s3 ls "s3://03d16464a6d64e079417436b1da8cc8e" --profile "development"

if ( $? -eq $false ) {
    aws s3 mb "s3://03d16464a6d64e079417436b1da8cc8e" `
    --profile "development" `
    --region "us-west-1"
}

aws cloudformation validate-template `
--template-body file://app.yaml `
--profile "development" `
--region "us-west-1"

aws cloudformation package `
--template-file .\app.yaml `
--s3-bucket "03d16464a6d64e079417436b1da8cc8e" `
--output-template-file .\package.yaml `
--profile "development"

aws cloudformation deploy `
--template-file .\package.yaml `
--stack-name "MattProofOfConcept" `
--capabilities CAPABILITY_IAM `
--profile "development" `
--region "us-west-1"