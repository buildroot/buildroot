################################################################################
#
# python-arrow
#
################################################################################

PYTHON_ARROW_VERSION = 1.3.0
PYTHON_ARROW_SOURCE = arrow-$(PYTHON_ARROW_VERSION).tar.gz
PYTHON_ARROW_SITE = https://files.pythonhosted.org/packages/2e/00/0f6e8fcdb23ea632c866620cc872729ff43ed91d284c866b515c6342b173
PYTHON_ARROW_SETUP_TYPE = setuptools
PYTHON_ARROW_LICENSE = Apache-2.0
PYTHON_ARROW_LICENSE_FILES = LICENSE

$(eval $(python-package))
