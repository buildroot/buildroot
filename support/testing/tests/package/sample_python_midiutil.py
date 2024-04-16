#! /usr/bin/env python3

# Taken from:
# https://github.com/MarkCWirt/MIDIUtil/blob/1.2.1/examples/c-major-scale.py

from midiutil import MIDIFile

degrees = [60, 62, 64, 65, 67, 69, 71, 72]  # MIDI note number
track = 0
channel = 0
time = 0        # In beats
duration = 1    # In beats
tempo = 60      # In BPM
volume = 100    # 0-127, as per the MIDI standard

MyMIDI = MIDIFile(1)  # One track
MyMIDI.addTempo(track, time, tempo)

for i, pitch in enumerate(degrees):
    MyMIDI.addNote(track, channel, pitch, time + i, duration, volume)

with open("major-scale.mid", "wb") as output_file:
    MyMIDI.writeFile(output_file)
