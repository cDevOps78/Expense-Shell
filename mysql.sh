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
mysql_secure_installation --set-root-pass ExpenseApp@1 &>> $logFileLocation
checkStatus "Setting Root Mysql password"


