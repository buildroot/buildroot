################################################################################
#
# nftables-python
#
################################################################################

# The following assignments work only because nftables.mk is included before
# this file is.
NFTABLES_PYTHON_VERSION = $(NFTABLES_VERSION)
NFTABLES_PYTHON_SOURCE = $(NFTABLES_SOURCE)
NFTABLES_PYTHON_SITE = $(NFTABLES_SITE)
NFTABLES_PYTHON_LICENSE = $(NFTABLES_LICENSE)
NFTABLES_PYTHON_LICENSE_FILES = $(NFTABLES_LICENSE_FILES)

# We share the same source code as nftables
NFTABLES_PYTHON_DL_SUBDIR = nftables

NFTABLES_PYTHON_SUBDIR = py

NFTABLES_PYTHON_SETUP_TYPE = setuptools

$(eval $(python-package))
