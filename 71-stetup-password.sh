#!/bin/bash
echo -e "$PASSWORD\n$PASSWORD" | passwd root
service ssh start
jupyter server --generate-config
python3 -c "from jupyter_server.auth.security import set_password; import os; set_password(password=os.environ['PASSWORD'])"
