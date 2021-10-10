################################################################################
#
# python-markdown2
#
################################################################################

PYTHON_MARKDOWN2_VERSION = 2.4.1
PYTHON_MARKDOWN2_SOURCE = markdown2-$(PYTHON_MARKDOWN2_VERSION).tar.gz
PYTHON_MARKDOWN2_SITE = https://files.pythonhosted.org/packages/fb/10/4f327f4517fa5dda90021618fe174d1f4aff3c4e06abcd7f77685a455511
PYTHON_MARKDOWN2_SETUP_TYPE = setuptools
PYTHON_MARKDOWN2_LICENSE = MIT
PYTHON_MARKDOWN2_LICENSE_FILES = LICENSE.txt
PYTHON_MARKDOWN2_CPE_ID_VENDOR = python-markdown2_project

$(eval $(python-package))
