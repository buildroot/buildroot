################################################################################
#
# python-mdit-py-plugins
#
################################################################################

PYTHON_MDIT_PY_PLUGINS_VERSION = 0.6.1
PYTHON_MDIT_PY_PLUGINS_SOURCE = mdit_py_plugins-$(PYTHON_MDIT_PY_PLUGINS_VERSION).tar.gz
PYTHON_MDIT_PY_PLUGINS_SITE = https://files.pythonhosted.org/packages/59/fc/f8d0863f8862f25602c0404d75568e89fb6b4109804645e5cdfb1be5cf56
PYTHON_MDIT_PY_PLUGINS_SETUP_TYPE = flit
PYTHON_MDIT_PY_PLUGINS_LICENSE = MIT
PYTHON_MDIT_PY_PLUGINS_LICENSE_FILES = LICENSE

$(eval $(python-package))
