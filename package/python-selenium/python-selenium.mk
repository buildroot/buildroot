################################################################################
#
# python-selenium
#
################################################################################

PYTHON_SELENIUM_VERSION = 4.27.1
PYTHON_SELENIUM_SOURCE_PYPI = selenium-$(PYTHON_SELENIUM_VERSION).tar.gz
PYTHON_SELENIUM_SITE_PYPI = https://files.pythonhosted.org/packages/44/8c/62c47c91072aa03af1c3b7d7f1c59b987db41c9fec0f158fb03a0da51aa6
PYTHON_SELENIUM_SITE = $(PYTHON_SELENIUM_SITE_PYPI)/$(PYTHON_SELENIUM_SOURCE_PYPI)?buildroot-path=filename
PYTHON_SELENIUM_SETUP_TYPE = setuptools-rust
PYTHON_SELENIUM_LICENSE = Apache-2.0
PYTHON_SELENIUM_LICENSE_FILES = LICENSE

$(eval $(python-package))
