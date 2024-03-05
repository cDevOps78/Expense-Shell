scriptPath=$(realpath "$PWD")

printHead "disable nodejs"
dnf module disable nodejs -y &>> /dev/null
checkStatus "disable nodejs"

printHead "enable nodejs"
dnf module enable nodejs:20 -y &>> /dev/null
checkStatus "enable nodejs"

printHead "Install nodejs"
dnf install nodejs -y &>> /dev/null
checkStatus "Install nodejs"

printHead "Adding user"
id expense
if [ $? -ne 0 ];then
useradd expense 
fi
checkStatus "Adding user"

printHead "Creating ddirectory"
mkdir -p /app &>> /dev/null
checkStatus "Creating ddirectory"

printHead "Downloading content"
curl  -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip  &>> /dev/null
checkStatus "Downloading content"

printHead "Unzipping content"
unzip -q -o /tmp/backend.zip -d /app &>> /dev/null
checkStatus "Unzipping content"

cd /app 

printHead "npm install"
npm install &>> /dev/null
checkStatus "npm install"

printHead "copying-script backend.service"
cp $scriptPath/backend.service /etc/systemd/system/backend.service 
checkStatus "copying-script backend.service"

printHead "Daemon-reload"
systemctl daemon-reload &>> /dev/null
checkStatus "Daemon-reload"

printHead "starting-backend"
systemctl enable backend  &>> /dev/null
checkStatus "starting-backend"

printHead "starting-backend"
systemctl start backend &>> /dev/null
checkStatus "starting-backend"

printHead "Install-mysql"
dnf install mysql -y &>> /dev/null
checkStatus "Install-mysql"

printHead "loading-schema"
mysql -h 172.31.18.205 -uroot -pExpenseApp@1 < /app/schema/backend.sql &>> /dev/null
checkStatus "loading-schema"

