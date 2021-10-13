## GuardDuty with email notification

In this lab we will deploy GuardDuty with email notification. This is useful to configure alert forwarding to the security teams mailbox. The stack can also be modified to send SMS messages or part of a more advanced workflow where it sends the data to e.g. Splunk or another SIEM.

1. Inspect the content of the Cloudformation stack.
2. Edit the "example@example.com on line 24 to correspond with your email. 
3. Deploy the edited stack.
4. Go to GuardDuty in the console, is it enabled? Are there any alerts?
5. Go to Amazon EventBridge - Rules. Can you see the rule for GuardDuty? What triggers the rule? What does it target? (see hint 1)
6. Click on the target in the EventBridge rule. Where does it email?
7. Confirm the email, does the status update?
8. Go back to GuardDuty - Settings - Click "Generate Sample findings".
9. Inspect the Findings that are generated. *Note: The example findings will not be sent to email.*


Hint 1:
<img width="1123" alt="Screen Shot 2021-10-13 at 1 21 26 PM" src="https://user-images.githubusercontent.com/26272119/137123443-93f7216a-51f6-4429-bbe8-ccc9e317ba22.png">


Hint 2:
<img width="1323" alt="Screen Shot 2021-10-13 at 1 22 26 PM" src="https://user-images.githubusercontent.com/26272119/137123874-f1342a67-16eb-4785-85fe-e4cbff27cd34.png">
