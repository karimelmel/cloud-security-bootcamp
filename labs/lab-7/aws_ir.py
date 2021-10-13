import boto3

access_key_to_deactivate=''
username=''
rolename=''

def disable_aws_access_keys(access_key_to_deactivate=access_key_to_deactivate,username=username):
    iam = boto3.resource('iam')
    access_key = iam.AccessKey(username,access_key_to_deactivate)
    response_status = access_key.deactivate()
    status_code = response_status['ResponseMetadata']['HTTPStatusCode']
    if status_code == 200:
        print(f"Access keys with identifier: {access_key_to_deactivate} has been disabled")
    else:
        print("Key deactivation failed")
        print(status_code)
disable_aws_access_keys()




def disable_aws_role(rolename=rolename):
    iam = boto3.client('iam')
    response = iam.put_role_policy(RoleName=rolename,PolicyName='Block',PolicyDocument='{"Version":"2012-10-17","Statement":{"Effect":"Deny","Action":"*","Resource":"*"}}')
    status_code = response['ResponseMetadata']['HTTPStatusCode']
    if status_code == 200:
        print(f"Block policy has been attached to role {rolename}")
    else:
        print("Policy attachment failed")
        print(status_code)
disable_aws_role()
