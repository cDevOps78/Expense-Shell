scriptPath=$(realpath "$PWD")
component="backend"

source $scriptPath/common.sh

printHead "disable nodejs"
dnf module disable nodejs -y &>> $logFileLocation
checkStatus "disable nodejs"

printHead "enable nodejs"
dnf module enable nodejs:20 -y &>> $logFileLocation 
checkStatus "enable nodejs"

printHead "Install nodejs"
dnf install nodejs -y &>> $logFileLocation
checkStatus "Install nodejs"

printHead "Adding user"
id expense &>> $logFileLocation
if [ $? -ne 0 ];then
useradd expense 
fi
checkStatus "Adding user"

printHead "Creating ddirectory"
mkdir -p /app &>> $logFileLocation
checkStatus "Creating ddirectory"

printHead "Downloading content"
curl  -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip  &>> $logFileLocation
checkStatus "Downloading content"

printHead "Unzipping content"
unzip -q -o /tmp/backend.zip -d /app &>> $logFileLocation
checkStatus "Unzipping content"

cd /app 

printHead "npm install"
npm install &>> $logFileLocation
checkStatus "npm install"

printHead "copying-script backend.service"
cp $scriptPath/backend.service /etc/systemd/system/backend.service 
checkStatus "copying-script backend.service"

printHead "Daemon-reload"
systemctl daemon-reload &>> $logFileLocation
checkStatus "Daemon-reload"

printHead "starting-backend"
systemctl enable backend  &>> $logFileLocation
checkStatus "starting-backend"

printHead "starting-backend"
systemctl start backend &>> $logFileLocation
checkStatus "starting-backend"

printHead "Install-mysql"
dnf install mysql -y &>> $logFileLocation
checkStatus "Install-mysql"

printHead "loading-schema"
mysql -h 172.31.18.205 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>> $logFileLocation
checkStatus "loading-schema"

