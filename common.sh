
function checkStatus() {

[ $? -ne '0' ] && echo -e "$R $1 is failure $N" && exit 1 ||  echo -e  "$G $1 is successfull $N" 

}
T
function colours () {
    R="\e[31m"
    G="\e[32m"
    N="\e[0m"
}


function printHead () {
 echo -e "$G------$1--------$N"
}

colours

