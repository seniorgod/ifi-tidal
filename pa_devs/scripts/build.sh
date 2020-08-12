#!/bin/bash
gcc ../src/pa_devs.c -lportaudio -lrt -lm -lasound -ljack -pthread -o ../bin/pa_devs
gcc ../src/ifi-pa-devs-get.c -lportaudio -lrt -lm -lasound -ljack -pthread -o ../bin/ifi-pa-devs-get
