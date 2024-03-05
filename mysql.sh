function colours () {
    R="\e[31m"
    G="\e[32m"
    N="\e[0m"
}

function printHead () {
 echo -e "$G------$1-----------$N"
}

printHead "Installing Mysql" 
dnf install mysql-server -y &>> /dev/null
echo $?

printHead "Enableing my sql"
systemctl enable mysqld &>> /dev/null
echo $?

printHead "Starting Mysql"
systemctl start mysqld   &>> /dev/null
echo $?

printHead "Setting Root Mysql password"
mysql_secure_installation --set-root-pass ExpenseApp@1 &>> /dev/null
echo $?