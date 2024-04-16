################################################################################
#
# python-chardet
#
################################################################################

PYTHON_CHARDET_VERSION = 5.2.0
PYTHON_CHARDET_SOURCE = chardet-$(PYTHON_CHARDET_VERSION).tar.gz
PYTHON_CHARDET_SITE = https://files.pythonhosted.org/packages/f3/0d/f7b6ab21ec75897ed80c17d79b15951a719226b9fababf1e40ea74d69079
PYTHON_CHARDET_SETUP_TYPE = setuptools
PYTHON_CHARDET_LICENSE = LGPL-2.1+
PYTHON_CHARDET_LICENSE_FILES = LICENSE

$(eval $(python-package))
