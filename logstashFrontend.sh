R="\e[31m"
G="\e[32m"
N="\e[0m"
function statusCheck() {
  [ $1 -ne 0 ] && echo -e "$2-${R}FAILED${N}" || echo "$2-${G}SUCCESS${N}"
}

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

dnf install logstash
statusCheck $? "Installing logstash"

#echo '
#input {
#  file {
#    path => "/var/log/nginx/access.log"
#  }
#}
#' >
