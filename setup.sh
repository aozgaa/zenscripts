#!/bin/bash

case "${1}" in
    enable)
        echo "initializing submodule"
        git submodule init
        git submodule update

        echo "generating scripts with hardcoded submodule path"
        bash disable-c6.sh.sh > disable-c6.sh
        chmod a+x disable-c6.sh

        bash disable-c6.service.sh > disable-c6.service

        echo "copying config files"
        sudo cp msr.conf /etc/modules-load.d/
        sudo cp disable-c6.sh /usr/lib/systemd/system-sleep/
        sudo cp disable-c6.service /etc/systemd/system/

        echo "starting+enabling systemd service"
        systemctl start disable-c6.service
        systemctl enable disable-c6.service

        sudo ./ZenStates-Linux/zenstates.py --c6-disable
        ;;
    disable)
        echo "stopping+disabling systemd service"
        systemctl stop disable-c6.service
        systemctl disable  disable-c6.service

        echo "removing config files"
        sudo rm /etc/modules-load.d/msr.conf
        sudo rm /usr/lib/systemd/system-sleep/disable-c6.sh
        sudo rm /etc/systemd/system/disable-c6.service

        echo "removing deleted service"
        systemctl daemon-reload

        sudo ./ZenStates-Linux/zenstates.py --c6-enable
        ;;
    *)
        echo "usage: setup.sh [enable/disable]"
        exit 1
esac



