#!/bin/bash

apt-get install python-software-properties
echo "install python-software-properties ====> Done"
sleep 5

add-apt-repository "deb http://archive.canonical.com/ lucid partner"
echo "add repository ===> Done"
sleep 5

sudo add-apt-repository ppa:ferramroberto/java
echo "add repository ===> Done"
sleep 5

apt-get update
echo "Update ===> Done"
sleep 5

apt-get install sun-java6-jdk
echo "install JDK ===> Done"
sleep 5

apt-get install sun-java6-jre sun-java6-plugin sun-java6-fonts
echo "install sun java ===> Done"
sleep 5

update-java-alternatives -s java-6-sun
echo "update java ===> Done"
sleep 5

cat > /etc/jvm <<EOF
/usr/lib/jvm/java-6-sun
EOF
echo "add to jvm ===> Done"
sleep 5

cat > /etc/bash.bashrc <<EOF
JAVA_HOME=/usr/lib/jvm/java-6-sun 
EOF
echo "add to bash ===> Done"
sleep 5

export JAVA_HOME
echo "export java ===> Done"
sleep 5

cat > /etc/environment <<EOF 
JAVA_HOME="/usr/lib/jvm/java-6-sun"
EOF
echo "add to environment if gui ===> Done"
sleep 5

echo "CREATE DATABASE lportal CHARACTER SET UTF8;GRANT ALL ON lportal.* to lportal@'localhost' IDENTIFIED BY 'lportal';GRANT ALL ON lportal.* to lportal@'localhost.localdomain' IDENTIFIED BY 'lportal';FLUSH PRIVILEGES;" | mysql -h "localhost" -u "root" -p
echo "Create databases ===> Done"
sleep 5

mkdir /etc/liferay
cd /etc/liferay
echo "Create Directory ===> Done"
sleep 5

wget http://nchc.dl.sourceforge.net/project/lportal/Liferay%20Portal/6.1.0%20GA1/liferay-portal-tomcat-6.1.0-ce-ga1-20120106155615760.zip
apt-get install unzip
unzip liferay-portal-tomcat-6.1.0-ce-ga1-20120106155615760.zip
mv /etc/liferay/l*/* /etc/liferay
echo "Download & unzip ===> Done"

cat > /etc/liferay/set-env.sh <<EOF
JAVA_OPTS="$JAVA_OPTS -Dfile.encoding=UTF8 -Duser.timezone=GMT -Xmx1024m -XX:MaxPermSize=256m"
EOF
echo "Create Java Script ===> Done"
sleep 5

cat > /etc/liferay/portal-ext.properties <<EOF
jdbc.default.driverClassName=com.mysql.jdbc.Driver
jdbc.default.url=jdbc:mysql://localhost/lportal?useUnicode=true&characterEncoding=UTF-8&useFastDateParsing=false
jdbc.default.username=lportal
jdbc.default.password=lportal
EOF
echo "file in same directory as tomcat ===> Done"
sleep 5

echo "install finish ===>http://localhost:8080<==="
