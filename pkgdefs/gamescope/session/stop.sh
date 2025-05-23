#!/bin/sh

steam -shutdown
sudo systemctl stop plugin_loader.service
asusctl profile -P Balanced