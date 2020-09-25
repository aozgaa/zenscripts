#!/bin/bash
script_dir=$(dirname $(readlink -f "$0"))
cat << EOF
#!/bin/sh
if [ "\${1}" == "post" ]; then
    # disable c6 coming out of sleep
    ${script_dir}/ZenStates-Linux/zenstates.py --c6-disable
fi
EOF
