#!/bin/bash

make
cd driver
rmmod cdc_acm
insmod arduino_usb.ko
chmod 666 /dev/arduino0
chmod 666 /dev/arduino1
