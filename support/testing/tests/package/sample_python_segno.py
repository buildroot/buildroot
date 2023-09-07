import segno
import os
import tempfile

qr = segno.make_qr('http:/www.example.org/')
with tempfile.NamedTemporaryFile('wb', suffix='.png', delete=False) as f:
    fn = f.name
qr.save(fn)
expected = b'\211PNG\r\n\032\n'  # PNG magic number
with open(fn, mode='rb') as f:
    val = f.read(len(expected))
os.unlink(fn)
assert expected == val
