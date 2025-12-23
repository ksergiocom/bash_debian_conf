#!/bin/bash

so=$(uname -o)
arch=$(uname -m)
kernel=$(uname -s)
version=$(uname -r)
full_version=$(uname -v)


cpu_physical=$(grep "cpu cores" /proc/cpuinfo | head -1 | tr '\t' ' ' | tr -s ' ' | cut -d ' ' -f 4)
cpu_virtual=$(grep "siblings" /proc/cpuinfo | head -1 | tr '\t' ' ' | tr -s ' ' | cut -d ' ' -f 3)

memory_available=$(free --mega | grep "Mem" | tr -s ' ' | cut -d ' ' -f 7)
memory_used=$(free --mega | grep "Mem" | tr -s ' ' | cut -d ' ' -f 3)
memory_perc=$(bc <<< "scale=2; $memory_used*100/$memory_available")

disk_total=0
disk_used=0
while read line
do
    total=$(echo "$line" | cut -d ' ' -f 2)
    used=$(echo "$line" | cut -d ' ' -f 3)
    
    disk_total=$((disk_total + total))
    disk_used=$((disk_used + used))
done < <(df -m | grep "/dev/" | grep -v "boot" | grep -v "tmp" | tr -s ' ' | tr -d %)
disk_perc=$(bc <<< "scale=2; $disk_used*100/$disk_total")

cpu_idle=$(vmstat | tail -1 | tr -s ' ' | cut -d ' ' -f 16)
cpu_usage=$((100 - cpu_idle))

last_reboot=$(uptime -s)

lvm_active="no"

if [ $(lsblk | grep "lvm" | wc -l) -gt 0 ]
then
    lvm_active="yes"
fi

active_tcp_cnx=$(ss -ta | wc -l)

# active_users=$(who | tr -s ' ' | cut -d ' ' -f 1 | wc -l)
active_unique_users=$(who | tr -s ' ' | cut -d ' ' -f 1 | sort -u | wc -l)

IPs=$(hostname -I)
MACs=$(ip a | grep "link/ether" | tr -s ' ' | cut -d ' ' -f 3 | tr '\n' ' ')

sudo_exec=$(journalctl _COMM=sudo -q | grep COMMAND | wc -l)

wall << EOF
######################################
.................@@. @@...............
...............#.      @..............
...............@   @.  :@.............
..........@@@:         :@.............
..............@        ::@............
..............:        ::@............
..............@        ::@............
..............+        .::@...........
.............@          ::@...........
.............@         .:::@..........
............:.          :::@..........
............@           ::::@.........
...........@            .:::@.........
............@%@          :@...........
................@ .@.@..@=............
..................@..@................
..................@...@...............
..................@...@...............
...............@@@@..@@...............
...................@*@................
######################################
SO: ${so}
Kernel: ${kernel}
version: ${version}
arch=$(uname -m)
kernel=$(uname -s)
######################################
Processors: $cpu_physical
vProcessors: $cpu_virtual
RAM: ${memory_used} / ${memory_available} MB (${memory_perc}%)
Disk: ${disk_used} / ${disk_total} MB (${disk_perc}%)
CPU%: ${cpu_usage}%
######################################
Last reboot: ${last_reboot}
LVM: ${lvm_active}
TCP: ${active_tcp_cnx}
Users: ${active_unique_users}
IPs: ${IPs}
MACs: ${MACs}
sudo(s): ${sudo_exec}
######################################
EOF