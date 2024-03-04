scriptPath=$(realpath "$PWD")

dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y

useradd expense

mkdir -p /app 

curl --silent -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip  


unzip -q -o /tmp/backend.zip -d /app

cd /app 
npm install 

cp $scriptPath/backend.service /etc/systemd/system/backend.service

systemctl daemon-reload

systemctl enable backend 
systemctl start backend

dnf install mysql -y

mysql -h 172.31.18.205 -uroot -pExpenseApp@1 < /app/schema/backend.sql


