################################################################################
#
# python-rpds-py
#
################################################################################

PYTHON_RPDS_PY_VERSION = 0.20.0
PYTHON_RPDS_PY_SOURCE_PYPI = rpds_py-$(PYTHON_RPDS_PY_VERSION).tar.gz
PYTHON_RPDS_PY_SITE_PYPI = https://files.pythonhosted.org/packages/55/64/b693f262791b818880d17268f3f8181ef799b0d187f6f731b1772e05a29a
PYTHON_RPDS_PY_SITE = $(PYTHON_RPDS_PY_SITE_PYPI)/$(PYTHON_RPDS_PY_SOURCE_PYPI)?buildroot-path=filename
PYTHON_RPDS_PY_SETUP_TYPE = maturin
PYTHON_RPDS_PY_LICENSE = MIT
PYTHON_RPDS_PY_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
