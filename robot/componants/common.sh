LOGFILE=/tmp/$COMPONENT.log
USERID=$(id -u)
if [ $USERID -ne 0 ] ; then
echo -e "\e[31m you must run this script as a root user \e[0m"
exit 1
fi

stat() {
if [ $1 -eq 0 ]; then
       echo -e "\e[32m succefull \e[0"
else 
       echo -e "\e[31m failure \e[0"
fi
}
