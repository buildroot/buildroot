#! /usr/bin/env python3
#
# This script generates a MIDI file with only 3 notes: A2, E3, A3
# usage: gen_midi_file.py [output-filename]

import sys

from midiutil import MIDIFile

output_filename = "output.mid"
if len(sys.argv) >= 2:
    output_filename = sys.argv[1]

notes = [57, 64, 69]  # A2, E3, A3

midi = MIDIFile()
midi.addTempo(track=0, time=0, tempo=60)

for i, p in enumerate(notes):
    midi.addNote(track=0, channel=0, pitch=p, time=i, duration=1, volume=100)

with open(output_filename, "wb") as output_file:
    midi.writeFile(output_file)
