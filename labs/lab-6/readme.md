## Lab objective
In this lab we will take a closer look at uploading our own SSM document and running it on an instance. The document will also cover incident response on AWS where it can trigger a memory dump on any Windows instance.


## Instructions
1. Deploy the Cloudformation stack "lab-6.yml".
2. Download "AcquireMemory.yml" file locally and inspect the content.
3. Go to AWS Console > Systems Manager > Documents > Create command or session
4. Give the document a suitable name.
5. Scroll down to Content, select YAML and paste the content from AcquireMemory.yml. Select Create document.
6. Search for the document or go to "Owned by me" tab.
7. Select Run Command, test it on one of your instances and inspect the output of the command.
8. Verify that the snapshot is in the S3 bucket.

