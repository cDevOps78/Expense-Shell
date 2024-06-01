
ami_id="ami-0e4fd655fb4e26c30"
security_group_id="sg-098c66671a7255c8e"
subnet_id="subnet-05bc9c749607ae9c2"

create_instance() {
  private_ip=$(aws ec2 run-instances \
    --image-id ${ami_id} \
    --instance-type t2.micro \
    --subnet-id ${subnet_id} \
    --security-group-ids ${security_group_id} \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${component}},{Key=Project,Value=RoboShop}]" \
    --instance-market-options "MarketType=spot,SpotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}" --query "Instances[].PrivateIpAddress" --output text)
}

for component in frontend
do
  create_instance
  echo "Private_IP =  ${private_ip}"
done
