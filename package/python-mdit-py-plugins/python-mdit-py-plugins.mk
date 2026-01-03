################################################################################
#
# python-mdit-py-plugins
#
################################################################################

PYTHON_MDIT_PY_PLUGINS_VERSION = 0.5.0
PYTHON_MDIT_PY_PLUGINS_SOURCE = mdit_py_plugins-$(PYTHON_MDIT_PY_PLUGINS_VERSION).tar.gz
PYTHON_MDIT_PY_PLUGINS_SITE = https://files.pythonhosted.org/packages/b2/fd/a756d36c0bfba5f6e39a1cdbdbfdd448dc02692467d83816dff4592a1ebc
PYTHON_MDIT_PY_PLUGINS_SETUP_TYPE = flit
PYTHON_MDIT_PY_PLUGINS_LICENSE = MIT
PYTHON_MDIT_PY_PLUGINS_LICENSE_FILES = LICENSE

$(eval $(python-package))
