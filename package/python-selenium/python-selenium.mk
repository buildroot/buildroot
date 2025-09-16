################################################################################
#
# python-selenium
#
################################################################################

PYTHON_SELENIUM_VERSION = 4.35.0
PYTHON_SELENIUM_SOURCE_PYPI = selenium-$(PYTHON_SELENIUM_VERSION).tar.gz
PYTHON_SELENIUM_SITE_PYPI = https://files.pythonhosted.org/packages/75/67/9016942b5781843cfea6f5bc1383cea852d9fa08f85f55a0547874525b5c
PYTHON_SELENIUM_SITE = $(PYTHON_SELENIUM_SITE_PYPI)/$(PYTHON_SELENIUM_SOURCE_PYPI)?buildroot-path=filename
PYTHON_SELENIUM_SETUP_TYPE = setuptools-rust
PYTHON_SELENIUM_LICENSE = Apache-2.0
PYTHON_SELENIUM_LICENSE_FILES = LICENSE

$(eval $(python-package))
