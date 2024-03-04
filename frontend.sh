dnf install nginx -y &>> /tmp/frontend.log

systemctl start nginx  &>> /tmp/frontend.log


rm -rf /usr/share/nginx/html/* 

curl --silent -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip 

unzip -q -o /tmp/frontend.zip  -d  /usr/share/nginx/html/ 

cp expense.conf /etc/nginx/default.d/expense.conf 

systemctl restart nginx  &>> /tmp/frontend.log


systemctl enable nginx  &>> /tmp/frontend.log


