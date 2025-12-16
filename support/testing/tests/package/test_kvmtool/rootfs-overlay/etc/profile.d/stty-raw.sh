# Avoid double-cooking the terminal, otherwise the test infrastructure
# would not be able to retrieve return codes properly.
grep -Fq br-kvm /proc/cmdline && stty raw
