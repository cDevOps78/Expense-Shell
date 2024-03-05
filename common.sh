

function colours () {
    R="\e[31m"
    G="\e[32m"
    N="\e[0m"
}


colours

logFileLocation="/tmp/$component.log"

function printHead () {
 echo -e "------$1--------"
 echo -e "------$1--------" >> $logFileLocation
}

function checkStatus() {

[ $? -ne '0' ] && echo -e "\n $R $1 is failure $N" && echo -e "\n $R Check for logs $logFileLocation $N"  && exit 1 ||  echo -e  "\n $G $1 is successfull $N" 

}

