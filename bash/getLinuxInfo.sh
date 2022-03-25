#!/bin/bash
cat /etc/os-release;
echo -e "\n";
lsb_release -a;
echo -e "\n";
hostnamectl;
echo -e "\n";
uname -r;
echo -e "\n";
env;
