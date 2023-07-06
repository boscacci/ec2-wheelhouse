aws ec2 create-image --instance-id YOUR_INSTANCE_ID --name "MyServer-AMI-$(date +%Y%m%d%H%M%S)" --description "AMI created from the current machine state"

