# test from https://github.com/pytransitions/transitions/blob/master/tests/test_nesting.py

from transitions.extensions import HierarchicalMachine as Machine

states = ['standing', 'walking', {'name': 'caffeinated', 'children': ['dithering', 'running']}]
transitions = [
  ['walk', 'standing', 'walking'],
  ['stop', 'walking', 'standing'],
  ['drink', 'caffeinated_dithering', '='],
  ['drink', 'caffeinated', 'caffeinated_dithering'],
  ['drink', '*', 'caffeinated'],
  ['walk', 'caffeinated', 'caffeinated_running'],
  ['relax', 'caffeinated', 'standing']
]

machine = Machine(states=states, transitions=transitions, initial='standing', ignore_invalid_triggers=True)

machine.walk()   # Walking now
machine.stop()   # let's stop for a moment
machine.drink()  # coffee time
machine.state
print(machine.state)
machine.drink()  # again!
print(machine.state)
machine.drink()  # and again!
print(machine.state)
machine.walk()   # we have to go faster
print(machine.state)
machine.stop()   # can't stop moving!
machine.state
print(machine.state)
machine.relax()  # leave nested state
machine.state    # phew, what a ride
print(machine.state)
