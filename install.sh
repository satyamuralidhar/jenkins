set -x

#fucntion for inatlling binaries

function installPackage() {
    local packagename=${1}
    apt-get install -y ${packagename}
}

#installing java
echo -e "'\033[1;32m'***********************************************\nJAVA_INSTALLATION\n***********************************************"
sleep 2
sudo apt-add-repository ppa:webupd8team/java -y
sudo apt-get update -y
# sudo apt-get install oracle-java8-installer
installPackage openjdk-8-jdk -y

#check java version
java --version

find / -name javac 
#To Set JAVA_HOME / PATH for all user, You need to setup global config in
#/etc/profile OR /etc/bash.bashrc file for all users:
profile=/etc/profile
java=sudo cat /etc/profile | grep -i "JAVA_HOME"

if [[ $java == 0 ]]
then
    echo "java found"
else
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/bin/javac >>  ${profile}
    export PATH=$PATH:$HOME/bin:$JAVA_HOME/bin >>  ${profile}
fi
#download maven binary
echo -e "'\033[1;33m'***********************************************\nMAVEN_INSTALLATION\n***********************************************"
sleep 2
cd /opt
if find -name apache;then rm -rf apache* && echo "'\033[0;91m'removed file";else echo "not found";fi
if find -name /usr/bin/mvn == 0;then rm -rf /usr/bin/mvn && echo "'\033[0;91m'removed folder";else echo "not  found";fi 
sudo wget http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
sudo tar xzf apache-maven-3.5.4-bin.tar.gz
sudo ln -s /opt/apache-maven-3.5.4/bin/mvn /usr/bin/mvn

maven=sudo cat /etc/profile | grep -i M2_HOME
if [[ $maven == 0 ]]
then 
    echo "maven found"
    maven --version
else
    M2_HOME=/opt/apache-maven-3.5.4 >> /etc/profile
    PATH=$PATH:$M2_HOME/bin >> /etc/profile
    export M2_HOME
    export PATH
fi

# installing git 
echo -e "'\033[1;32m'***********************************************\nGIT_INSTALLATION\n***********************************************"
installPackage git 

# installing jenkins
echo -e "'\033[0;92m***********************************************\nGIT_INSTALLATION\n***********************************************"
sudo wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y 
installPackage jenkins
sudo service jenkins status
