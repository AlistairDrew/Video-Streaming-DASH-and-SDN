#!/bin/bash

#Installing necessary packages 
sudo apt-get update -y
sudo apt-get -y install unzip vim wget
sudo apt-get -y install openjdk-8-jre
sudo update-alternatives --config java

echo 'export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre' >> ~/.bashrc
source ~/.bashrc
echo $JAVA_HOME
wget https://nexus.opendaylight.org/content/repositories/opendaylight.release/org/opendaylight/integration/karaf/0.8.4/karaf-0.8.4.zip
sudo mkdir /usr/local/karaf
sudo mv karaf-0.8.4.zip /usr/local/karaf
sudo unzip /usr/local/karaf/karaf-0.8.4.zip -d /usr/local/karaf/
sudo update-alternatives --install /usr/bin/karaf karaf /usr/local/karaf/karaf-0.8.4/bin/karaf 1
sudo update-alternatives --config karaf
which karaf


sudo -E karaf < echo 'feature:install odl-restconf odl-l2switch-switch odl-mdsal-apidocs odl-dluxapps-applications'

# feature:install odl-restconf
# feature:install odl-l2switch-switch
# feature:install odl-mdsal-apidocs
# feature:install odl-dluxapps-applications





