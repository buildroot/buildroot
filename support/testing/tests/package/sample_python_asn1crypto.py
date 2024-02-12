from asn1crypto import pem, x509


with open('/etc/ssl/certs/ISRG_Root_X2.pem', 'rb') as f:
    der_bytes = f.read()
    if pem.detect(der_bytes):
        type_name, headers, der_bytes = pem.unarmor(der_bytes)

cert = x509.Certificate.load(der_bytes)

assert cert.subject.native["common_name"] == "ISRG Root X2"
