#!/bin/bash

cat /opt/beef-for-cerberus/depen/config.yml | grep authtoken > /dev/null 2>&1
if [ $? -eq 1 ]; then
    echo "Al parecer no has configurado tu authtoken, Porque no lo hacemos?"
    echo "Ingresa tu authtoken, para mas informacion en https://dashboard.ngrok.com/auth/your-authtoken"
    read token
    echo -e "authtoken: $token" > /opt/beef-for-cerberus/depen/config.yml
    cat /opt/beef-for-cerberus/depen/config.yml >> depen/cerberus.yml 
fi

pushd /opt/beef-for-cerberus > /dev/null
python3 cerberus.py $@
popd > /dev/null
