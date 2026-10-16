import snappy

payload = b"Buildroot python-snappy runtime test\n"
compressed = snappy.compress(payload)
decompressed = snappy.uncompress(compressed)
