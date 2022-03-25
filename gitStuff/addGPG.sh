#!/bin/bash
# https://docs.github.com/en/github/authenticating-to-github/managing-commit-signature-verification

gpg --version;
# 1. gen key
gpg --full-generate-key;
# if gpg version < 2.1.17
# gpg --default-new-key-algo rsa4096 --gen-key

# 1.1 At the prompt, specify the kind of key you want, or press Enter to accept the default.
# 1.2 At the prompt, specify the key size you want, or press Enter to accept the default. Your key must be at least 4096 bits.
# 1.3 Enter the length of time the key should be valid. Press Enter to specify the default selection, indicating that the key doesn't expire.
# 1.4 Verify that your selections are correct.
# 1.5 Enter your user ID information.
# 1.6 Type a secure passphrase.

# 2. List key
gpg --list-secret-keys --keyid-format=long

# 3. select gpg key id you want to use
: '$ gpg --list-secret-keys --keyid-format=long
/Users/hubot/.gnupg/secring.gpg
------------------------------------
sec   4096R/3AA5C34371567BD2 2016-03-10 [expires: 2017-03-10]
uid                          Hubot 
ssb   4096R/42B317FD4BA89E7A 2016-03-10'
# 3AA5C34371567BD2 is the key id in example above

# 4. Tell git to use your gpg key
git config --global user.signingkey [key_id]
git config --global commit.gpgsign true

# 5. Export gpg key and add to github account
gpg --armor --export [key_id]
# https://github.com/settings/keys

# Del key
gpg --delete-secret-keys [key_id]

# bash
echo "default-cache-ttl 3600" > ~/.gnupg/gpg-agent.conf
# this will save passphrase for 1 hour