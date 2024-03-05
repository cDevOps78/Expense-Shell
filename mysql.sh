component="mysql"
source $PWD/common.sh

printHead "Installing Mysql" 
dnf install mysql-server -y &>> /dev/null
checkStatus "Installing Mysql"

printHead "Enableing my sql"
systemctl enable mysqld &>> /dev/null
checkStatus "Enableing my sql"

printHead "Starting Mysql"
systemctl start mysqld   &>> /dev/null
checkStatus "Starting Mysq"


printHead "Setting Root Mysql password"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>> /dev/null
checkStatus "Setting Root Mysql password"

printHead "Checking-status to exit"
