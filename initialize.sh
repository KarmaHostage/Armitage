#!/bin/bash
echo "starting postgres"
service postgresql start

echo "changing to user: postgres"
sudo -u postgres bash << EOF
echo $(whoami)
echo "creating msf user and db"
psql -c "CREATE USER msf WITH PASSWORD 'msf';"
createdb -O msf msf

echo "creating msf_test user and db"
psql -c "CREATE USER msf_test WITH PASSWORD 'msf_test';"
createdb -O msf_test msf_test

EOF

echo "going to use $ARMITAGE_PASSWORD as password"

msfupdate
teamserver 0.0.0.0 $ARMITAGE_PASSWORD
