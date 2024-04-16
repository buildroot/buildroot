#! /usr/bin/env python3
#
# This script reads the output of the "aubionotes" command and
# validates it contains three expected notes (A2, E3, A3) in the
# correct order. Silences or other notes are allowed in between those
# notes, to allow some flexibility.

import sys

found = 0
notes = [57, 64, 69]

for line in sys.stdin:
    fields = line.split()
    if len(fields) >= 1:
        value = round(float(fields[0]))
        if value == notes[found]:
            found += 1
        if found == len(notes):
            print("Found all notes")
            sys.exit(0)

print("Error: all notes not found")
sys.exit(1)
