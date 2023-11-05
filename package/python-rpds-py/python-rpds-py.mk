################################################################################
#
# python-rpds-py
#
################################################################################

PYTHON_RPDS_PY_VERSION = 0.12.0
PYTHON_RPDS_PY_SOURCE = rpds_py-$(PYTHON_RPDS_PY_VERSION).tar.gz
PYTHON_RPDS_PY_SITE = https://files.pythonhosted.org/packages/75/be/e3f366aa4cd1e3a814f136773e506fc5423eff903ef0372a251df34e6e45
PYTHON_RPDS_PY_SETUP_TYPE = maturin
PYTHON_RPDS_PY_LICENSE = MIT
PYTHON_RPDS_PY_LICENSE_FILES = LICENSE

$(eval $(python-package))
