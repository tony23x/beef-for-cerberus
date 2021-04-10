#!/bin/bash

curl -s -N http://127.0.0.1:4040/api/tunnels | grep '{"name":"vic (http)","uri":"/api/tunnels/vic%20%28http%29","public_url":"http://[0-9a-z]*\.ngrok.io' -oh | tr '"' ' ' | awk '{print $13}' > vic.txt
