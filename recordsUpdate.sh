# To list hosted-zones

zone_id=$(aws route53  list-hosted-zones-by-name --dns-name azcart.online --query "HostedZones[].Id" --output text | awk -F"/" '{print $3}' )

dns_name=$(aws route53  list-hosted-zones-by-name --dns-name azcart.online --query "DNSName" --output text)

echo "zone_id = ${zone_id}"
echo "dns_name = ${dns_name}"


for record_name in frontend backend mysql ; do


#aws route53 change-resource-record-sets --hosted-zone-id ${zone_id} --change-batch


cat << EOF > last.json
{
    "Comment": "Update record of $record_name",
    "Changes": [
        {
            "Action": "UPSERT",
            "ResourceRecordSet": {
                "Name": "$record_name.$dns_name",
                "Type": "A",
                "TTL": 30,
                "ResourceRecords": [
                    {
                        "Value": "15.207.247.28"
                    }
                ]
            }
        }
    ]
}
EOF

aws route53 change-resource-record-sets --hosted-zone-id ${zone_id} --change-batch file://last.json

done

rm -rf last.json