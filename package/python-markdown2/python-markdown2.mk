################################################################################
#
# python-markdown2
#
################################################################################

PYTHON_MARKDOWN2_VERSION = 2.5.3
PYTHON_MARKDOWN2_SOURCE = markdown2-$(PYTHON_MARKDOWN2_VERSION).tar.gz
PYTHON_MARKDOWN2_SITE = https://files.pythonhosted.org/packages/44/52/d7dcc6284d59edb8301b8400435fbb4926a9b0f13a12b5cbaf3a4a54bb7b
PYTHON_MARKDOWN2_SETUP_TYPE = setuptools
PYTHON_MARKDOWN2_LICENSE = MIT
PYTHON_MARKDOWN2_LICENSE_FILES = LICENSE.txt
PYTHON_MARKDOWN2_CPE_ID_VALID = YES

$(eval $(python-package))
