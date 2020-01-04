#!/bin/bash

apt-get install apache2 -y
a2enmod rewrite
service apache2 restart

# Disable apache 2 on startup to prevent unintended 
systemctl disable apache2
