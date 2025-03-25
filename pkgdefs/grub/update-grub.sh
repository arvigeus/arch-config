#!/bin/bash

grub-mkconfig -o /boot/grub/grub.cfg
sed -i 's/echo/#echo/g' /boot/grub/grub.cfg