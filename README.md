# Proof.AWS.PostImagesViaAPIGateway

## Deploy

The build script assumes you've got a profile named "development" with an associated key and secret for an account with rights to build the stack.

1. Clone the repository to your local machine.
2. Start the build script.
```
.\build.ps1
```

## Test

1. Login to the AWS console.
2. Navigate to the API gateway.
3. Look for the new API (i.e., -Default).
4. Goto the API's "v1" stage.
5. Retrieve the URL for the `image\submit` endpoint's post method.
6. From your HTTP client of choice, send the `sample-message.json` (see root directory of respository) to the retrieved endpoint.