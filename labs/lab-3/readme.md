## Lab objective
In this lab we will learn to work with GitHub actions and deploy AWS CloudFormation templates by using the third party action for AWS Cloudformation. We will also add secrets to our GitHub repository as environment variables allowing access to deploy resources in AWS.

## Instructions
1. In your fork of the repository, add the following variables to your repository as Secrets based on the IAM credentials created in Lab 1:
"AWS_ACCESS_KEY_ID" and "AWS_SECRET_ACCESS_KEY".	
2. In your Fork of the repository go to Actions, create a new workflow.
3. Select the simple workflow, remove the default code and paste the workflow found here: https://gist.github.com/karimelmel/e6b7e5e9d34edc9a36560e5d1f178c4e
4. Follow the status on the Github actions task
5. Go to AWS console - CloudFormation and see what happens. 
6. Delete the stack before proceeding!
