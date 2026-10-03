################################################################################
#
# python-multipart
#
################################################################################

PYTHON_MULTIPART_VERSION = 0.0.32
PYTHON_MULTIPART_SOURCE = python_multipart-$(PYTHON_MULTIPART_VERSION).tar.gz
PYTHON_MULTIPART_SITE = https://files.pythonhosted.org/packages/5b/42/55c32bb9b12693c092ad250a0e82edb5b31ddeda6eb772de5f308b3804ad
PYTHON_MULTIPART_SETUP_TYPE = hatch
PYTHON_MULTIPART_LICENSE = Apache-2.0
PYTHON_MULTIPART_LICENSE_FILES = LICENSE.txt
PYTHON_MULTIPART_CPE_ID_VENDOR = fastapiexpert

$(eval $(python-package))
