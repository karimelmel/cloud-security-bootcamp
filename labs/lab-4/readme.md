## Lab objective
In this lab we will learn to use cfn_nag together with GitHub Actions to perform static analysis of CloudFormation templates. We will resolve the errors by adding Metadata to our CloudFormation template and then deploying without errors.

## Instructions
1. Access your fork of the repository
2. Update your GitHub Actions yaml (in .github/workflows/) file to include deployment of the vpc.yml in labs/lab-4/vpc.yml.
4. Add an a Step to also use cfn_nag action to scan the file. https://github.com/marketplace/actions/cfn-nag-action 
    a. If you want to have a look at the solution: https://gist.github.com/karimelmel/39f62d8e59096d5a322b20e4ec9d2ba6

4. Look at the errors thrown by cfn_nag in your GitHub actions. Go to AWS console and delete the stack. 
5. Now follow the guidance provided on how to use cfn_nag to suppress these warnings.
6. Remember the format shown in the presentation where you use Metadata in the CloudFormation template to suppress this.
7. Try commiting the code which will trigger the action. Make sure that the action deploys correctly without any warnings before proceeding.


Note: The stack deployed through this lab is required for future labs. Do not delete the stack until complete with all labs.
