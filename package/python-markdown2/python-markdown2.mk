################################################################################
#
# python-markdown2
#
################################################################################

PYTHON_MARKDOWN2_VERSION = 2.5.1
PYTHON_MARKDOWN2_SOURCE = markdown2-$(PYTHON_MARKDOWN2_VERSION).tar.gz
PYTHON_MARKDOWN2_SITE = https://files.pythonhosted.org/packages/05/92/22e3645e352562ea9bfc89aeaeb9a76feb79e20907b18bc25d5ca340b50f
PYTHON_MARKDOWN2_SETUP_TYPE = setuptools
PYTHON_MARKDOWN2_LICENSE = MIT
PYTHON_MARKDOWN2_LICENSE_FILES = LICENSE.txt
PYTHON_MARKDOWN2_CPE_ID_VALID = YES

$(eval $(python-package))
