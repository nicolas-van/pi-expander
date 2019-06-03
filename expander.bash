#!/bin/bash

function playnote() {
  NOTE=$1
  DURATION=$2

  echo "noteon 1 $NOTE 100" >  /dev/tcp/localhost/9988
  sleep DURATION
  echo "noteoff 1 $NOTE" >  /dev/tcp/localhost/9988
}

trap "kill 0" EXIT

fluidsynth -is -o "shell.port=9988" --gain 2 --audio-driver=alsa -z=64 "/usr/share/sounds/sf2/FluidR3_GM.sf2" &

sleep 10
aconnect 20 128

playnote 60 0.2
playnote 67 0.2
playnote 72 0.2

while [ 1 ];
do
	sleep 1
done
