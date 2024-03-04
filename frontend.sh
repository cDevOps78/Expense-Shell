dnf install nginx -y

systemctl start nginx 

rm -rf /usr/share/nginx/html/* 

curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip 

unzip -q -o /tmp/frontend.zip  -d  /usr/share/nginx/html/

cp expense.conf /etc/nginx/default.d/expense.conf 

systemctl restart nginx


systemctl enable nginx