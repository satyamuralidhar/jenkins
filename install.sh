#set -x

#fucntion for inatlling binaries

function installPackage() {
    local packagename=${1}
    apt-get install -y ${packagename}
}

#installing java
echo -e "***********************************************\nJAVA_INSTALLATION\n***********************************************"
sudo apt-get update -y
# sudo apt-get install oracle-java8-installer
installPackage openjdk-11-jdk -y

#check java version
java -version

find / -name javac 
#To Set JAVA_HOME / PATH for all user, You need to setup global config in
#/etc/profile OR /etc/bash.bashrc file for all users:
java=sudo cat /etc/profile | grep -i "JAVA_HOME"

if [[ $java == 0 ]]
then
    echo "java found"
else
    cat >> /etc/profile << EOF
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/bin/java
export PATH=$PATH:$HOME/bin:$JAVA_HOME/bin
EOF
fi
#download maven binary
echo -e "***********************************************\nMAVEN_INSTALLATION\n***********************************************"
sleep 2
cd /opt
if find -name /opt/apache == 0;then rm -rf apache* && echo "removed file";else echo "not found";fi
if find -name /usr/bin/mvn == 0;then rm -rf /usr/bin/mvn && echo "removed folder";else echo "not  found";fi 
sudo wget http://www-eu.apache.org/dist/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz
sudo tar xzf apache-maven-3.5.4-bin.tar.gz
sudo ln -s /opt/apache-maven-3.5.4/bin/mvn /usr/bin/mvn

maven=sudo cat /etc/profile | grep -i "M2_HOME"
if [[ $maven == 0 ]]
then 
    echo "maven found"
    maven --version
else
    cat >> /etc/profile << EOF
M2_HOME=/opt/apache-maven-3.5.4
PATH=$PATH:$M2_HOME/bin
export M2_HOME
export PATH
EOF
fi

# installing git 
echo -e "***********************************************\nGIT_INSTALLATION\n***********************************************"
installPackage git 

# installing jenkins
echo -e "***********************************************\nGIT_INSTALLATION\n***********************************************"
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key |sudo gpg --dearmor -o /usr/share/keyrings/jenkins.gpg
sudo sh -c 'echo deb [signed-by=/usr/share/keyrings/jenkins.gpg] http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y 
installPackage jenkins
sudo service jenkins status
