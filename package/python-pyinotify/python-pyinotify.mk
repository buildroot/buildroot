################################################################################
#
# python-pyinotify
#
################################################################################

PYTHON_PYINOTIFY_VERSION = 0.9.6
PYTHON_PYINOTIFY_SOURCE = pyinotify-$(PYTHON_PYINOTIFY_VERSION).tar.gz
PYTHON_PYINOTIFY_SITE = https://files.pythonhosted.org/packages/e3/c0/fd5b18dde17c1249658521f69598f3252f11d9d7a980c5be8619970646e1
PYTHON_PYINOTIFY_SETUP_TYPE = setuptools
PYTHON_PYINOTIFY_LICENSE = MIT
PYTHON_PYINOTIFY_LICENSE_FILES = COPYING

$(eval $(python-package))
