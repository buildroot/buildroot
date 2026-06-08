# Avoid double-cooking the inner serial console, otherwise the test
# infrastructure cannot reliably retrieve return codes.
grep -Fq br-inner-virgl /proc/cmdline && stty raw
