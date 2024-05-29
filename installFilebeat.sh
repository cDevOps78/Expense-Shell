# password=$1

R="\e[31m"
G="\e[32m"
N="\e[0m"


function statusCheck() {
  echo "$2" &>> /tmp/logstash.log
  [ $1 -ne 0 ] && echo -e "\n$2-${R}FAILED${N}" && echo "Check-Logs --> /tmp/logstash.log for more info!!" || echo -e "\n$2-${G}SUCCESS${N}"
}

> /tmp/logstash.log

echo '
[elasticsearch]
name=Elasticsearch repository for 8.x packages
baseurl=https://artifacts.elastic.co/packages/8.x/yum
gpgcheck=0
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
' > /etc/yum.repos.d/elasticSearch.repo
statusCheck $? "Set up elasticSearch repo"

dnf install filebeat -y  &>> /tmp/logstash.log
statusCheck $? "Installing filebeat"

systemctl start filebeat &>> /tmp/logstash.log
statusCheck $? "Start filebeat service"

systemctl enable filebeat &>> /tmp/logstash.log
statusCheck $? "Enable filebeat service"




