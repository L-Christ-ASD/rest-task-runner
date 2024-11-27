#!/bin/bash

# Check if postgres is installed
which psql

# If not install
if [ $? -ne 0 ] ; then
 apt install curl ca-certificates
 install -d /usr/share/postgresql-common/pgdg
 curl -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc --fail https://www.postgresql.org/media/keys/ACCC4CF8.asc
 sh -c 'echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
 apt update
 apt upgrade
 apt -y install postgresql

fi

# Enable service 
systemctl daemon-reload
systemctl enable postgresql

# Switch to postgres user
sudo -u postgres -i

# Create database
psql -c "CREATE DATABASE challenge"

# Create admin user
psql -c "CREATE USER admin WITH PASSWORD 'pwd';"
psql -c "GRANT ALL PRIVILEGES ON DATABASE challenge TO admin;"

# Create users
users=(["test"]='123' ["Nico"]='1234' ["mathias"]="1")
for new_user in $users
do
psql -c "CREATE USER $new_user WITH PASSWORD ${users[$new_user]}"
done