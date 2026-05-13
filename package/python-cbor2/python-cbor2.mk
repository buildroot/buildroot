################################################################################
#
# python-cbor2
#
################################################################################

PYTHON_CBOR2_VERSION = 5.6.5
PYTHON_CBOR2_SOURCE = cbor2-$(PYTHON_CBOR2_VERSION).tar.gz
PYTHON_CBOR2_SITE = https://files.pythonhosted.org/packages/e4/aa/ba55b47d51d27911981a18743b4d3cebfabccbb0598c09801b734cec4184
PYTHON_CBOR2_SETUP_TYPE = setuptools
PYTHON_CBOR2_LICENSE = MIT
PYTHON_CBOR2_LICENSE_FILES = LICENSE.txt
PYTHON_CBOR2_DEPENDENCIES = host-python-setuptools-scm
PYTHON_CBOR2_ENV = CBOR2_BUILD_C_EXTENSION=1
HOST_PYTHON_CBOR2_DEPENDENCIES = host-python-setuptools-scm
HOST_PYTHON_CBOR2_ENV = CBOR2_BUILD_C_EXTENSION=0

# 0001-CVE-2025-64076.patch
PYTHON_CBOR2_IGNORE_CVES += CVE-2025-64076

# 0002-CVE-2025-68131.patch
PYTHON_CBOR2_IGNORE_CVES += CVE-2025-68131

# 0003-CVE-2026-26209.patch 0004-CVE-2026-26209.patch
PYTHON_CBOR2_IGNORE_CVES += CVE-2026-26209

$(eval $(python-package))
$(eval $(host-python-package))
