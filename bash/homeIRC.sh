#!/bin/bash
# https://ubuntu.com/tutorials/irc-server#6-server-configuration

sudo apt install git perl g++ make weechat -y;
# https://github.com/inspircd/inspircd/releases/latest
wget https://github.com/inspircd/inspircd/archive/v2.0.25.tar.gz;
tar xvf ./v2.0.25.tar.gz;

cd "inspircd-2.0.25";
perl ./configure;
make install;
mkdir -p ./inspircd-2.0.25/run/conf/;
(
	echo '<config format="xml">'
	echo '<define name="bindip" value="1.2.2.3">'
	echo '<define name="localips" value="&bindip;/24">'
	echo ''
	echo '# SERVER_HOSTNAME/FQDN: Hostname for the server'
	echo '# SERVER_DESCRIPTION: A description for your server'
	echo '# SERVER_SID: A unique sequence of 3 characters, the first being a number (make sure to capitalise)'
	echo '# NETWORK_NAME: The name of your IRC network'
	echo '# ADNIN_NAME: IRC admin name'
	echo '# ADMIN_NICK: IRC admin nick'
	echo '# ADMIN_EMAIL: IRC admin email'
	echo '# SERVER_IP: Public IP for the server'
	echo '# SERVER_PORT: Server port (usually 6697)'
	echo '# SERVER_TYPE: The clients or servers type (clients should be fine here)'
	echo ''
	echo '# Example:'
	echo '# <server name="tutorials.ubuntu.com" description="Welcome to Ubuntu Tutorials" id="97K" network="tutorials.ubuntu.com">'
	echo '# <admin name="tutorial ubuntu" nick="tutorial" email="tutorials@ubuntu.com">'
	echo '# <bind address="23.54.785.654" port="6697" type="clients">'
	echo ''
	echo '####### SERVER CONFIGURATION #######'
	echo '<server name="SERVER_HOSTNAME/FQDN" description="SERVER_DESCRIPTION" id="SERVER_SID" network="NETWORK_NAME">'
	echo '<admin name="ADMIN_NAME" nick="ADMIN_NICK" email="ADMIN_EMAIL">'
	echo '<bind address="SERVER_IP" port="SERVER_PORT" type="clients">'
) >> ./run/conf/inspircd.conf;

nano -l ./run/conf/inspircd.conf && ./run/inspircd start && ./run/inspircd status;