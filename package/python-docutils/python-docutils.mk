################################################################################
#
# python-docutils
#
################################################################################

PYTHON_DOCUTILS_VERSION = 0.19
PYTHON_DOCUTILS_SOURCE = docutils-$(PYTHON_DOCUTILS_VERSION).tar.gz
PYTHON_DOCUTILS_SITE = https://files.pythonhosted.org/packages/6b/5c/330ea8d383eb2ce973df34d1239b3b21e91cd8c865d21ff82902d952f91f
PYTHON_DOCUTILS_LICENSE = Public Domain, BSD-2-Clause, BSD-3-Clause, Python-2.0, GPL-3.0+ (emacs mode)
PYTHON_DOCUTILS_LICENSE_FILES = COPYING.txt
PYTHON_DOCUTILS_SETUP_TYPE = setuptools

$(eval $(python-package))
$(eval $(host-python-package))
