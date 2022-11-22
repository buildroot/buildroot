import hashlib
from binascii import hexlify, unhexlify

from hkdf import Hkdf, hkdf_expand, hkdf_extract

salt = b"ThisIsTheSalt."
key_in = b"ThisIsTheSecretKey"
key_info = b"KeyInfo1"
key_len = 16
expected_key = unhexlify(b"b49d6cc9065b72f3a0859377d8bb7299")

prk = hkdf_extract(salt, input_key_material=key_in, hash=hashlib.sha512)
key1 = hkdf_expand(prk, info=key_info, length=key_len)

print("key1:", hexlify(key1))
assert key1 == expected_key

kdf = Hkdf(salt, input_key_material=key_in, hash=hashlib.sha512)
key2 = kdf.expand(info=key_info, length=key_len)

print("key2:", hexlify(key2))
assert key2 == expected_key
