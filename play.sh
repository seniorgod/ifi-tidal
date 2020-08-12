#!/bin/bash
# Title:
#
#       iFi Streamer Tidal Connect Service
# Description:
#
#       This program gets an available output device and implement the Tidal Connect Service.
# Copyright:
#
#       Willard Ting - ifi-audio.com
# History:
#
#       2020/08/12      Willard         First release

FULL_PATH=$(realpath ${0})
THIS_NAME=${FULL_PATH##*/}
SAME_DIR=${FULL_PATH%${THIS_NAME}}
HOSTNAME=$(cat /etc/hostname)
BROADCAST_NAME="${HOSTNAME^}'s Streamer"

# Get the current available output devices
${SAME_DIR}pa_devs/run.sh

# Get the user-set output device from volumio's UI configuration
GREP=$(cat /data/configuration/audio_interface/alsa_controller/config.json | jq -r '.outputdevicename.value')
if [ -e ${SAME_DIR}pa_devs/devices ]; then
	# Match the device name acceptable for portaudio
	OUTPUT=$(grep -i "${GREP}" ${SAME_DIR}pa_devs/devices | cut -d '=' -f 2)
	if [ -z "${OUTPUT}" ]; then
		# If no device's name matched, set the USB DAC as default
		OUTPUT=$(grep -i 'usb' ${SAME_DIR}pa_devs/devices | cut -d '=' -f 2)
		if [ -z "${OUTPUT}" ]; then
			# If no USB DAC, set the first available device as default
			OUTPUT=$(grep -i 'device#0' ${SAME_DIR}pa_devs/devices | cut -d '=' -f 2)
		fi
	fi
fi

if [ -n "${OUTPUT}" ]; then
	# Start the Tidal Connect Service
	${SAME_DIR}bin/tidal_connect_application \
				--clientid "hWhSHB4pzu3c8vU9" \
				--tc-certificate-path "${SAME_DIR}id_certificate/IfiAudio_ZenStream.dat" \
				--netif-for-deviceid eth0 \
				-f "${BROADCAST_NAME}" \
				--playback-device "${OUTPUT}" \
				--log-level 1
else
	echo "Error: no output devices at all!"
	exit 1
fi
