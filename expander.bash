#!/bin/bash

set -e

function playnote() {
  NOTE=$1
  DURATION=$2

  echo "noteon 1 $NOTE 100" >  /dev/tcp/localhost/9988
  sleep $DURATION
  echo "noteoff 1 $NOTE" >  /dev/tcp/localhost/9988
}

trap "kill 0" EXIT

fluidsynth -is -o "shell.port=9988" -o "synth.polyphony=10" -R off -C off --gain 1 --audio-driver=alsa -z=64 "/usr/share/sounds/sf2/FluidR3_GM.sf2" &

sleep 10
aconnect 20 128

amixer cset numid=1 - 100%

playnote 60 0.1
playnote 60 0.1
playnote 60 0.1
playnote 60 0.4
playnote 56 0.4
playnote 58 0.4
playnote 60 0.2
playnote 58 0.1
playnote 60 0.8

while [ 1 ];
do
	sleep 1
done
