#!/bin/sh

[ -z "$1" ] || [ "x$1" = "xstart" ] || exit 0

psplash_write "Setup ALSA hack..."

# Play a dummy WAV.
# This fixes the audio hardware not working properly after reset.
/usr/bin/aplay /usr/share/alsa/dummy.wav >/dev/null 2>&1

# Unmute DAC
amixer -q -D hw:rs90audio cset "name='Master Playback Switch'" on
