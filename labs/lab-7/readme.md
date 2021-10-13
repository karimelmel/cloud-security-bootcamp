## Lab objective
In this lab we will try out some automated IR playbooks for responding to an event in AWS. We will use the boto3 library to automated two actions: Disabling of Access Keys and to add a block policy to an existing role.

First, we will deploy a new EC2 instance. The instance will have the script aws_ir.py bootstrapped to the root directory. The script accepts the following three parameters:
* access_key_to_deactivate
* username
* rolename


## Lab instructions
1. Deploy the Cloudformation stack "lab-7.yml".
2. Inspect the  "aws_ir.py" script.
3. Go to AWS Console > IAM > Users
4. On the user created for GitHub actions, take note of the Access Key ID under the Security Credentials tab.
5. Connect to the EC2 Instance deployed using Session Manager.
6. Change directory to root directory, by typing 'cd /'
7. Open the aws_ir.py file in your favorite editor and add the missing parameters. (See hint 1)
8. Run the aws_ir.py script and see what happens.
9. Go to console and inspect status of the access keys
10. Go to Console and look at the policies associated with the role. 


Hint 1:
<img width="742" alt="Screen Shot 2021-10-13 at 9 49 16 AM" src="https://user-images.githubusercontent.com/26272119/137090248-f7512789-13ba-418d-a0bb-d88efc944cd6.png">
