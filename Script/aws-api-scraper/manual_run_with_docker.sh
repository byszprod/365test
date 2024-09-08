#!/bin/bash

docker build -t test_scraper . --no-cache

# Run aws-vault to assume role and get environment variables
eval $(aws-vault exec $AWS_PROFILE -- env | grep AWS)

# Now run the Docker container with the user-provided environment variables
docker run -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
           -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
           -e AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN \
           -e AWS_SECURITY_TOKEN=$AWS_SECURITY_TOKEN \
           -e AWS_REGION=$AWS_REGION \
           -v ./output/:/app/output \
           test_scraper