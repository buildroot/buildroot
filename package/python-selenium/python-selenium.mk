################################################################################
#
# python-selenium
#
################################################################################

PYTHON_SELENIUM_VERSION = 4.51.0
PYTHON_SELENIUM_SOURCE_PYPI = selenium-$(PYTHON_SELENIUM_VERSION).tar.gz
PYTHON_SELENIUM_SITE_PYPI = https://files.pythonhosted.org/packages/c3/d3/c925308af2c9b9a9ccf531cf23ffba4f38c0d750f088a06e560fb2ca0c59
PYTHON_SELENIUM_SITE = $(PYTHON_SELENIUM_SITE_PYPI)/$(PYTHON_SELENIUM_SOURCE_PYPI)?buildroot-path=filename
PYTHON_SELENIUM_SETUP_TYPE = setuptools-rust
PYTHON_SELENIUM_LICENSE = Apache-2.0
PYTHON_SELENIUM_LICENSE_FILES = LICENSE

$(eval $(python-package))
