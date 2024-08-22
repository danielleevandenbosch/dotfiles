#!/bin/bash

pactl load-module module-remap-sink sink_name=mono master=alsa_output.usb-GeneralPlus_USB_Audio_Device-00.analog-stereo sink_properties=device.description=Mono channel_map=mono,mono

