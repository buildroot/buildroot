################################################################################
#
# python-selenium
#
################################################################################

PYTHON_SELENIUM_VERSION = 4.52.0
PYTHON_SELENIUM_SOURCE_PYPI = selenium-$(PYTHON_SELENIUM_VERSION).tar.gz
PYTHON_SELENIUM_SITE_PYPI = https://files.pythonhosted.org/packages/96/07/d9a9ca4bbcfaad6e07e8034ccd719ef42032ab25a421fb9171baad4ed734
PYTHON_SELENIUM_SITE = $(PYTHON_SELENIUM_SITE_PYPI)/$(PYTHON_SELENIUM_SOURCE_PYPI)?buildroot-path=filename
PYTHON_SELENIUM_SETUP_TYPE = setuptools-rust
PYTHON_SELENIUM_LICENSE = Apache-2.0
PYTHON_SELENIUM_LICENSE_FILES = LICENSE

$(eval $(python-package))
