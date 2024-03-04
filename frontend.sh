function printHead(){
 echo "$1"   
}

dnf install nginx -y &>> /tmp/frontend.log

echo $?

systemctl start nginx  &>> /tmp/frontend.log

echo $?
rm -rf /usr/share/nginx/html/* 
echo $?

curl --silent -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip 
echo $?

unzip -q -o /tmp/frontend.zip  -d  /usr/share/nginx/html/ 
echo $?

cp expense.conf /etc/nginx/default.d/expense.conf 
echo $?

systemctl restart nginx  &>> /tmp/frontend.log

echo $?


systemctl enable nginx  &>> /tmp/frontend.log
echo $?


