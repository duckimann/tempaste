sudo adduser [username] && sudo usermod -aG sudo $_

# remove user
sudo userdel [username]

# verify user belongs to sudo group
groups [username]