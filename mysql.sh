component="mysql"

source $PWD/common.sh

printHead "Installing Mysql" 
dnf install mysql-server -y &>> $logFileLocation 
checkStatus "Installing Mysql"

printHead "Enableing my sql"
systemctl enable mysqld &>> $logFileLocation
checkStatus "Enableing my sql"

printHead "Starting Mysql"
systemctl start mysqld   &>> $logFileLocation
checkStatus "Starting Mysq"


printHead "Setting Root Mysql password"
echo 'show databases' |  mysql -h 172.31.18.205 -uroot -pExpenseApp@1 &&>> $logFileLocation
if [ $? -ne 0 ];then
mysql_secure_installation --set-root-pass ExpenseApp@1 &>> $logFileLocation
fi
checkStatus "Setting Root Mysql password"


