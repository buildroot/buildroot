################################################################################
#
# python-dnspython
#
################################################################################

PYTHON_DNSPYTHON_VERSION = 2.7.0
PYTHON_DNSPYTHON_SOURCE = dnspython-$(PYTHON_DNSPYTHON_VERSION).tar.gz
PYTHON_DNSPYTHON_SITE = https://files.pythonhosted.org/packages/b5/4a/263763cb2ba3816dd94b08ad3a33d5fdae34ecb856678773cc40a3605829
PYTHON_DNSPYTHON_LICENSE = ISC
PYTHON_DNSPYTHON_LICENSE_FILES = LICENSE
PYTHON_DNSPYTHON_SETUP_TYPE = hatch

# 0001-Limit-decompression-to-a-chain-length-of-at-most-16-.patch
PYTHON_DNSPYTHON_IGNORE_CVES += CVE-2026-114605

$(eval $(python-package))
$(eval $(host-python-package))
