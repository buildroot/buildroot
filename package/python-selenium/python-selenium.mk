################################################################################
#
# python-selenium
#
################################################################################

PYTHON_SELENIUM_VERSION = 4.16.0
PYTHON_SELENIUM_SOURCE = selenium-$(PYTHON_SELENIUM_VERSION).tar.gz
PYTHON_SELENIUM_SITE = https://files.pythonhosted.org/packages/16/fd/a0ef793383077dd6296e4637acc82d1e9893e9a49a47f56e96996909e427
PYTHON_SELENIUM_SETUP_TYPE = setuptools
PYTHON_SELENIUM_LICENSE = Apache-2.0

$(eval $(python-package))
