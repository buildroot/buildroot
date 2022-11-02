################################################################################
#
# python-beautifulsoup4
#
################################################################################

PYTHON_BEAUTIFULSOUP4_VERSION = 4.11.1
PYTHON_BEAUTIFULSOUP4_SOURCE = beautifulsoup4-$(PYTHON_BEAUTIFULSOUP4_VERSION).tar.gz
PYTHON_BEAUTIFULSOUP4_SITE = https://files.pythonhosted.org/packages/e8/b0/cd2b968000577ec5ce6c741a54d846dfa402372369b8b6861720aa9ecea7
PYTHON_BEAUTIFULSOUP4_SETUP_TYPE = setuptools
PYTHON_BEAUTIFULSOUP4_LICENSE = MIT
PYTHON_BEAUTIFULSOUP4_LICENSE_FILES = LICENSE

$(eval $(python-package))
