#1/bin/bash

if [ $(id -u) -ne 0 ]; then
   echo -e "You should perform this as root user"
   exit 1
fi
stat() { 
    if [ $1 -ne  ]; then
       echo "Installation Failed : Check log /tmp/jinstall.log”
       exit 2
fi 
        }

   

yum install fontconfig java-11-openjdkjdevel wget -y &>/tmp/jinstall.log
Stat $?
wget --no-check-certificate -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo &>>/tmp/jinstall.log
Stat $?

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key &>>/tmp/jinstall.log
Stat $?

yum install jenkins -y &>>/tmp/jinstall.log
Stat $?

systemctl enable jenkins &>>/tmp/jinstall.log
Stat $?

systemctl start jenkins &>>/tmp/jinstall.log
Stat $?

echo -e "\e[32m INSTALLATION SUCCESSFUL\e[0m

mkdir -p /var/1ib/jenkins/.ssh
echo 'Host *
UserKnownHostsFile /dev/null
strictHostKeyChecking no’ >/var/lib/jenkins/.ssh/config
chown jenkins:jenkins /var/1ib/jenkins/.ssh -R
chmod 400 /var/1ib/jenkins/.ssh/config