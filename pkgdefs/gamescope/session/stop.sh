#!/bin/sh

steam -shutdown
sudo systemctl start plugin_loader.service
# asusctl profile -P Balanced