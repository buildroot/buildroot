################################################################################
#
# python-rpds-py
#
################################################################################

PYTHON_RPDS_PY_VERSION = 0.30.0
PYTHON_RPDS_PY_SOURCE_PYPI = rpds_py-$(PYTHON_RPDS_PY_VERSION).tar.gz
PYTHON_RPDS_PY_SITE_PYPI = https://files.pythonhosted.org/packages/20/af/3f2f423103f1113b36230496629986e0ef7e199d2aa8392452b484b38ced
PYTHON_RPDS_PY_SITE = $(PYTHON_RPDS_PY_SITE_PYPI)/$(PYTHON_RPDS_PY_SOURCE_PYPI)?buildroot-path=filename
PYTHON_RPDS_PY_SETUP_TYPE = maturin
PYTHON_RPDS_PY_LICENSE = MIT
PYTHON_RPDS_PY_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
