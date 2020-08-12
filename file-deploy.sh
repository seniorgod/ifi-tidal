#!/bin/bash
cp ifi-streamer-tidal-connect.service /lib/systemd/system/
chmod +x /usr/ifi/ifi-tidal/play.sh
chmod +x /usr/ifi/ifi-tidal/pa_devs/run.sh
#systemctl enable ifi-streamer-tidal-connect.service
