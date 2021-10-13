## Lab objective
In this lab we will learn about IAM Access Analyzer and how it detects resources that are public or vulnerable. 

The resource policy for the Secret in Secrets Manager is vulnerable as it alllows a wildcard in the Principal section, meaning that any Principal, even outside of the AWS account can retrieve the secret value. 

```
{
   "Version": "2012-10-17",
   "Statement": [
      {
         "Resource": "*",
         "Action": "Secretsmanager:GetSecretValue",
         "Effect": "Allow",
         "Principal": "*"
      }
   ]
}
```


## Instructions
1. Deploy the Cloudformation stack "lab-9.yml".
2. Download "lab-9.yml" and familiarize with the stack content. Are there any obvious vulnerabilities? 
3. Notice the wildcard in Principal.
4. Go to AWS console - CloudFormation and deploy the stack
5. Once the stack has finished deploying, go to IAM - Access Analyzer and review the findings. 
6. Try remediating the vulnerable resources and see if the alert disappears.
7. Once the finding has been remediated go to IAM - Access Analyzer and verify it has been resolved.

<img width="1282" alt="Screen Shot 2021-10-13 at 8 34 31 AM" src="https://user-images.githubusercontent.com/26272119/137079871-4f2d9f3f-624f-4f5a-a47c-e6523011175d.png">


Hint 1: You need to change the resource policy by restricting it to a role in your account or <accountid>:root (all authenticated principals)
  
Hint 2: The finding can be remediated through the console.
1. Go to Secrets Manager in the AWS Console - Select the secret. Scroll down to 
2. Click Edit on key policy, remove the resource policy and add the correct policy.

Hint 3: The below policy will remediate the finding. Note that you must replace the account ID in the policy below with your own.
```
{
  "Version" : "2012-10-17",
  "Statement" : [ {
    "Effect" : "Allow",
         "Principal": {
            "AWS": "arn:aws:iam::112233445566:root"
            },
    "Action" : "Secretsmanager:GetSecretValue",
    "Resource" : "*"
  } ]
}
```


  
