## Lab objective
In this lab we will prepare for future labs by forking the repository. We will also set up CloudTrail logging to better understand AWS API logging. We will create access keys for a later stage of the labs that we will store securely.

After that we will inspect CloudTrail to see that actions we performed can be tracked.

## Instructions
1. Log in to Github.com. Access the repository: https://github.com/karimelmel/cloud-security-bootcamp
2. Create a fork of the repository
3. Log in to your AWS account.
4. Turn on API logging using CloudTrail. Set up forwarding to CloudWatch Logs and S3
5. Go to Identity and Access Management. Create a user with Access Keys that you will use later in the course. Assign the user the following permissions: "AdministratorAccess". Note: In a production environment we would use less sensitive permissions.
Verify the logs are accessible in S3 and CloudWatch logs. 
