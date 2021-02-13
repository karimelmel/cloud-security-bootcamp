## Lab objective
In this lab you will deploy 2 instances in the VPC that was deployed in the previous lab. Make sure that the VPC exists before starting thins lab
Instance with the name EC2-A will have Instance Metadata Service Version set to 1. The other instance will be set to Version 2. The objective of this session is to use AWS SSM Session Manager to connect to the instance and experience the difference between version 1 and version 2.
Later you will try applying a Systems Manager Document to an instance that configures Microsoft Security Compliance Baseline. Pay attention to the risks associated with your actions, we will discuss these after the lab.

## Instructions
1. Go to CloudFormation, deploy the template ec2.yml.
2. Use AWS Sessions Manager to connect to the instance named EC2-A. Try accessing the local metadata endpoint on 169.254.169.254 using curl. (hint: https://docs.aws.amazon.com/AWSEC2/latest/WindowsGuide/instancedata-data-retrieval.html)
3. Are you able to extract the session and use it in your CLI or from a client or instance with AWS CLI installed by running "aws configure"? (hint 2: Invoke-RestMethod -uri http://169.254.169.254/latest/meta-data/iam/security-credentials/)
4. Now use AWS Sessions Manager to connect to the instance named EC2-B. Try accessing the local metadata endpoint using the same method.
5. Figure out how to retrieve a token to access the instance metadata service. Why is this more secure? Try extracing the credentials and use them from another instance with aws cli installed and running "aws configure". Does the credentials work?
6. Go to Systems Manager, under Node Management select "Run command" > Click the "Run Command" button. Search for the document "ApplyMicrosoftSecurityComplianceBaseline". Make sure the owner is account "454212039551"!@
7. Inspect the document content. What are the unknown risks when running this document? How does it compare to any other software you download and install?
8. Run the document by choosing "Specify instances manually". Select your instances (EC2-A and EC2-B). 
9. Select one of the instances
10. Inspect the output of this document.