#!/bin/bash

### Password agin ###############################

# PASS_MAX_DAYS: Tiempo expiración.
# PASS_MIN_DAYS: Tiempo mínimo antes de poder cambiar la contraseña
# PASS_WARN_AGE: Dias cuando empieza a aparecer el warning

sed -i 's/^\s*PASS_MAX_DAYS\s\+.*/PASS_MAX_DAYS   365/' /etc/login.defs
sed -i 's/^\s*PASS_MIN_DAYS\s\+.*/PASS_MIN_DAYS   1/' /etc/login.defs
sed -i 's/^\s*PASS_WARN_AGE\s\+.*/PASS_WARN_AGE   300/' /etc/login.defs

### Contraseña fuerte ###########################

# https://www.debian.org/doc/manuals/securing-debian-manual/ch04s11.en.html
apt-get install \
    libpam-pwquality

sed -i 's|^\s*password\s\+requisite\s\+pam_pwquality\.so\s\+retry=3.*|password  requisite  pam_pwquality.so retry=3 minlen=12 dcredit=-1 ucredit=-1 lcredit=-1 ocredit=-1 difok=7 maxrepeat=3 reject_username enforce_for_root|' /etc/pam.d/common-password

