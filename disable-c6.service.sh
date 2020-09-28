#!/bin/bash
script_dir=$(dirname $(readlink -f "$0"))
cat << EOF
[Unit]
Description=Disable C6 on boot
After=default.target

[Service]
Type=oneshot
ExecStart=${script_dir}/ZenStates-Linux/zenstates.py --c6-disable

[Install]
WantedBy=default.target
EOF
