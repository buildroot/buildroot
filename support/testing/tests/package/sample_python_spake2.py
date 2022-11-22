from binascii import hexlify

from spake2 import SPAKE2_A, SPAKE2_B


shared_password = b"This Is The Password!"

alice = SPAKE2_A(shared_password)
alice_msg = alice.start()

bob = SPAKE2_B(shared_password)
bob_msg = bob.start()

# Alice and Bob exchange their messages...

alice_key = alice.finish(bob_msg)
bob_key = bob.finish(alice_msg)

print("alice_key:", hexlify(alice_key))
print("  bob_key:", hexlify(bob_key))

assert alice_key == bob_key
