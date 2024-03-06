
scriptPath=$(realpath "$PWD")
component="backend"
source $scriptPath/common.sh

printHead "Install nginx"
dnf install nginx -y &>> $logFileLocation
checkStatus "Install nginx"



printHead "removing the old content"
rm -rf /usr/share/nginx/html/* &>> $logFileLocation
checkStatus "removing the old content"

printHead "Downloading-content"
curl  -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip  &>> $logFileLocation
checkStatus "Downloading-content"

printHead "Unzipping content"
unzip  -o /tmp/frontend.zip  -d  /usr/share/nginx/html/ &>>  $logFileLocation
checkStatus "Unzipping content"

printHead "copying .conf-file"
cp $scriptPath/expense.conf /etc/nginx/default.d/expense.conf &>> $logFileLocation
checkStatus "copying .conf-file"

printHead "restarting nginx"
systemctl restart nginx  &>> $logFileLocation
checkStatus "restarting nginx"


printHead "enable nginx"
systemctl enable nginx  &>> $logFileLocation
checkStatus "enable nginx"


