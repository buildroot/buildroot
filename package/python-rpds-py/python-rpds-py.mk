################################################################################
#
# python-rpds-py
#
################################################################################

PYTHON_RPDS_PY_VERSION = 0.18.1
PYTHON_RPDS_PY_SOURCE_PYPI = rpds_py-$(PYTHON_RPDS_PY_VERSION).tar.gz
PYTHON_RPDS_PY_SITE_PYPI = https://files.pythonhosted.org/packages/2d/aa/e7c404bdee1db7be09860dff423d022ffdce9269ec8e6532cce09ee7beea
PYTHON_RPDS_PY_SITE = $(PYTHON_RPDS_PY_SITE_PYPI)/$(PYTHON_RPDS_PY_SOURCE_PYPI)?buildroot-path=filename
PYTHON_RPDS_PY_SETUP_TYPE = maturin
PYTHON_RPDS_PY_LICENSE = MIT
PYTHON_RPDS_PY_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
