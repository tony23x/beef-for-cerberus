#!/bin/bash
curl -s -N http://127.0.0.1:4040/api/tunnels | tr '"' ' ' | tr '}' '\n' | grep ',{ name : beef , uri : /api/tunnels/beef , public_url : ' | awk '{print $12}' > panel.txt
