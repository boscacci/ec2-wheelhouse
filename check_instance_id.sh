aws ec2 describe-instances --query 'Reservations[*].Instances[*].InstanceId' --filters Name=instance-state-name,Values=running --output text

