## Lab objective
In this lab we will learn to perform the same actions as we did in Lab 1 but through using Infrastructure as Code. We will also deploy an AWS S3 Bucket with a Bucket (resource) Policy. CloudTrail service will have write access to the bucket. 

## Instructions
1. Go to GitHub and make sure you are accessing the Forked version of the repository.
2. Go to the folder: labs - labs-2. Inspect the content in lab-2.yml
3. Launch AWS Console and go to CloudFormation. Try uploading and deploying the template. 
4. Once the template is deployed, verify that you have another S3 Bucket and CloudTrail configured in your account. Attempt to delete the bucket.
5. If the bucket fails to delete, empty the bucket content by going to S3 console and try deleting the stack again.
