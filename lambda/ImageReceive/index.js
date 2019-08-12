const AWS = require('aws-sdk');

exports.handler = async (event) => {
    console.log(event);

    const response = {
        statusCode: 200,
        body: "",
    };

    const imageS3BucketName = process.env.ImageBucket;

    let errorMessage;
    let status = true;

    try {
		const s3 = new AWS.S3();

        // Decode the Image
        const requestBody = JSON.parse(event.body);
        const imageEncoded = requestBody.image;
        const imageDecoded = Buffer.from(imageEncoded, 'base64');

        // Derive the image file's name
        const imageFileType = requestBody.fileType;
        const imageFileName = requestBody.fileName;

        const options = {
            "Body": imageDecoded,
            "Bucket": imageS3BucketName,
            "Key": `${imageFileName}.${imageFileType}`
        };

        // Upload the image
        const s3_file_write_result = await s3.upload(options).promise();

        const imageItem = {
            "submittedDate": JSON.stringify(new Date()),
            "customerIdentity": event.body.identity,
            "bucketUploadConfirmation": s3_file_write_result,
            "currentStatus": "staged"
        };

        console.log(imageItem);

    } catch(error) {
        status = false;
        errorMessage = error.toString();
    }

    response.body = JSON.stringify({ status, errorMessage });
    return response;
};