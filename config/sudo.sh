#!/bin/bash

mkdir -p /var/log/sudo


# tee SI respeta sudo
# > normal NO

tee /etc/sudoers.d/sudo_config > /dev/null << 'EOF'
Defaults passwd_tries=3
Defaults badpass_message="Mensaje de error personalizado"
Defaults logfile="/var/log/sudo/sudo_config"
Defaults log_input, log_output
Defaults iolog_dir="/var/log/sudo"
Defaults requiretty
Defaults secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin"
EOF
