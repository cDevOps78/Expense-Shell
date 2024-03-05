
function checkStatus() {

[[ $? == '0' ]] && echo "$G $1 is successfull $N" || echo "$R $1 is failure $N"

}

function colours () {
    R="\e[31m"
    G="\e[32m"
    N="\e[0m"
}


function printHead () {
 echo -e "$G------$1-----------$N"
}

colours

