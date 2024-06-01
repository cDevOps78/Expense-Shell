
ami_id="ami-0e4fd655fb4e26c30"
security_group_id="sg-098c66671a7255c8e"
subnet_id="subnet-05bc9c749607ae9c2"


zone_id=$(aws route53  list-hosted-zones-by-name --dns-name azcart.online --query "HostedZones[].Id" --output text | awk -F"/" '{print $3}' )
dns_name=$(aws route53  list-hosted-zones-by-name --dns-name azcart.online --query "DNSName" --output text)

create_instance() {
  private_ip=$(aws ec2 run-instances \
    --image-id ${ami_id} \
    --instance-type t2.micro \
    --subnet-id ${subnet_id} \
    --security-group-ids ${security_group_id} \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=${component}},{Key=Project,Value=RoboShop}]" \
    --instance-market-options "MarketType=spot,SpotOptions={SpotInstanceType=persistent,InstanceInterruptionBehavior=stop}" --query "Instances[].PrivateIpAddress" --output text)

    cat << EOF > /tmp/route53_record.json
    {
        "Comment": "Update record of $component",
        "Changes": [
            {
                "Action": "UPSERT",
                "ResourceRecordSet": {
                    "Name": "${component}-dev.$dns_name",
                    "Type": "A",
                    "TTL": 30,
                    "ResourceRecords": [
                        {
                            "Value": "${private_ip}"
                        }
                    ]
                }
            }
        ]
    }
EOF
aws route53 change-resource-record-sets --hosted-zone-id ${zone_id} --change-batch file:///tmp/route53_record.json

}


for component in frontend
do
  create_instance


done
