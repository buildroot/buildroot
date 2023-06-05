################################################################################
#
# python-selenium
#
################################################################################

PYTHON_SELENIUM_VERSION = 4.9.1
PYTHON_SELENIUM_SOURCE = selenium-$(PYTHON_SELENIUM_VERSION).tar.gz
PYTHON_SELENIUM_SITE = https://files.pythonhosted.org/packages/fd/e2/0e5bee6762a7bf7852b47a79c5b12f9e526e6962958dbb9719fa490ba24c
PYTHON_SELENIUM_SETUP_TYPE = setuptools
PYTHON_SELENIUM_LICENSE = Apache-2.0

$(eval $(python-package))
