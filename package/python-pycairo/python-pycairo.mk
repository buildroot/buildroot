################################################################################
#
# python-pycairo
#
################################################################################

PYTHON_PYCAIRO_VERSION = 1.29.0
PYTHON_PYCAIRO_SOURCE = pycairo-$(PYTHON_PYCAIRO_VERSION).tar.gz
PYTHON_PYCAIRO_SITE = https://files.pythonhosted.org/packages/22/d9/1728840a22a4ef8a8f479b9156aa2943cd98c3907accd3849fb0d5f82bfd
PYTHON_PYCAIRO_DEPENDENCIES = cairo
PYTHON_PYCAIRO_LICENSE = LGPL-2.1 or MPL-1.1
PYTHON_PYCAIRO_LICENSE_FILES = COPYING COPYING-LGPL-2.1 COPYING-MPL-1.1

PYTHON_PYCAIRO_CONF_OPTS = \
	-Dpython=$(HOST_DIR)/bin/python \
	-Dtests=false \
	-Dwheel=false

PYTHON_PYCAIRO_CONF_ENV = \
	_PYTHON_SYSCONFIGDATA_NAME=$(PKG_PYTHON_SYSCONFIGDATA_NAME) \
	PYTHONPATH=$(PYTHON3_PATH)

$(eval $(meson-package))
