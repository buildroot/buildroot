################################################################################
#
# python-selenium
#
################################################################################

PYTHON_SELENIUM_VERSION = 4.26.1
PYTHON_SELENIUM_SOURCE_PYPI = selenium-$(PYTHON_SELENIUM_VERSION).tar.gz
PYTHON_SELENIUM_SITE_PYPI = https://files.pythonhosted.org/packages/3f/b1/e9efcb88d5682e802cf03bdee4886f854d75bdb2859d1e72cb74041b4ef6
PYTHON_SELENIUM_SITE = $(PYTHON_SELENIUM_SITE_PYPI)/$(PYTHON_SELENIUM_SOURCE_PYPI)?buildroot-path=filename
PYTHON_SELENIUM_SETUP_TYPE = setuptools-rust
PYTHON_SELENIUM_LICENSE = Apache-2.0
PYTHON_SELENIUM_LICENSE_FILES = LICENSE

$(eval $(python-package))
