#!/bin/bash

# This is a guide, not an automated script.
# Make ssh not ask the password

# Step 0: Cd to ssh dir
cd ~/.ssh

# Step 1: Gen the key
ssh-keygen -b 4096;
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/{{name}} -C {{your_email_addr}} # this is the new one

# then enter the file name (will be saved under ~/.ssh)
# if you're on linux
ssh-copy-id username@ip;

# Step 2: copy the public key to the target you want to connect to
scp ~/.ssh/[key_name].pub username@ip:~/.ssh/authorized_keys; # Execute this command if you name the file differently

# Step 3: Edit config
nano -l /etc/ssh/sshd_config; # file on the target you want to connect to
# Server's /etc/ssh/sshd_config:
# 1. To enable password authentication, uncomment
# #PasswordAuthentication yes

# 2. To enable root login, uncomment
# #PermitRootLogin yes

# 3. To enable ssh key login, uncomment
# #PubkeyAuthentication yes
# #AuthorizedKeysFile .ssh/authorized_keys

# 4. Change port
# Port 22


# Step 4: shorten the ssh command
# Vid: https://youtu.be/gxpX_mubz2A?t=905
nano -l ~/.ssh/config # file on current machine
# Template
:'
Host wolfgangvpn
	User wolfgang
	Port 69
	IdentityFile ~/.ssh/id_rsa
	HostName 139.162.245.193
'
# Then login with the hostname
ssh wolfgangvpn

# Step 5: Protect it with endlessh
# Docker image: linuxserver/endlessh
# Vid: https://www.youtube.com/watch?v=SKhKNUo6rJU
sudo apt install libc6-dev make -y; # make sure to have libc6 and make
git clone https://github.com/skeeto/endlessh;
cd endlessh;
make;
cp endlessh /usr/local/bin/;
which endlessh # verify does endlessh is copied
sudo cp util/endlessh.service /etc/systemd/system/;
sudo systemd enable endlessh;
mkdir -p /etc/endlessh && sudo echo "Port 22" > /etc/endlessh/config;
sudo systemd start endlessh;
netstat -tulpn | grep endlessh; # verify endlessh is running on port 22

# Or using filewall (ufw aka UncomplicatedFirewall / iptables)
sudo apt install ufw -y;
sudo ufw allow 69 # only open configured port
sudo ufw enable # enable on startup
sudo ufw status # show status
