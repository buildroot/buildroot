################################################################################
#
# python-html5lib
#
################################################################################

PYTHON_HTML5LIB_VERSION = 1.1
PYTHON_HTML5LIB_SOURCE = html5lib-$(PYTHON_HTML5LIB_VERSION).tar.gz
PYTHON_HTML5LIB_SITE = https://files.pythonhosted.org/packages/ac/b6/b55c3f49042f1df3dcd422b7f224f939892ee94f22abcf503a9b7339eaf2
PYTHON_HTML5LIB_LICENSE = MIT
PYTHON_HTML5LIB_LICENSE_FILES = LICENSE
PYTHON_HTML5LIB_SETUP_TYPE = setuptools

$(eval $(python-package))
