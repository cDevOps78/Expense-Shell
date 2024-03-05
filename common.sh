function checkStatus() {

[[ $? == '0' ]] && echo "$1 is successfull" || echo "$1 is failure"
}


date &> /dev/null

checkStatus "Running date commad"

