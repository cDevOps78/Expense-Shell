function printHead(){
 echo "$1"   
}

# printHead "Installing nginx"
echo "Installing nginx"
dnf install nginx -y &>> /tmp/frontend.log

echo $?
printHead "Starting nginx"
systemctl start nginx  &>> /tmp/frontend.log
echo $?
printHead "Removing-content"
rm -rf /usr/share/nginx/html/* 
echo $?
printHead "Dowlaod"
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


