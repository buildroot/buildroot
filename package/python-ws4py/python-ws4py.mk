################################################################################
#
# python-ws4py
#
################################################################################

PYTHON_WS4PY_VERSION = 0.6.0
PYTHON_WS4PY_SOURCE = ws4py-$(PYTHON_WS4PY_VERSION).tar.gz
PYTHON_WS4PY_SITE = https://files.pythonhosted.org/packages/cb/55/dd8a5e1f975d1549494fe8692fc272602f17e475fe70de910cdd53aec902
PYTHON_WS4PY_SETUP_TYPE = setuptools
PYTHON_WS4PY_LICENSE = BSD-3-Clause
PYTHON_WS4PY_LICENSE_FILES = LICENSE

$(eval $(python-package))
