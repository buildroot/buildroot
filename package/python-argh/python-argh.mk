################################################################################
#
# python-argh
#
################################################################################

PYTHON_ARGH_VERSION = 0.28.1
PYTHON_ARGH_SOURCE = argh-$(PYTHON_ARGH_VERSION).tar.gz
PYTHON_ARGH_SITE = https://files.pythonhosted.org/packages/bf/77/6758074453c83c7ac0456d397e95aaa91b33fbd2ec977dcf38be736ea177
PYTHON_ARGH_SETUP_TYPE = flit
PYTHON_ARGH_LICENSE = LGPL-3.0+
PYTHON_ARGH_LICENSE_FILES = COPYING COPYING.LESSER

$(eval $(python-package))
