import gnupg

gpg = gnupg.GPG(verbose=True)

plain_data = "Some plain text data"
good_passphrase = "Good Passphrase"

# Test Encrypt
result = gpg.encrypt(plain_data, None, passphrase=good_passphrase, symmetric=True)
assert(result.returncode == 0)
enc_data = str(result)
assert(enc_data != plain_data)

# Test Good Decrypt
result = gpg.decrypt(enc_data, passphrase=good_passphrase)
assert(result.returncode == 0)
dec_data = str(result)
assert(dec_data == plain_data)

# Test Bad Decrypt
result = gpg.decrypt(enc_data, passphrase='A Wrong Passphrase')
assert(result.returncode != 0)
dec_data = str(result)
assert(dec_data != plain_data)
