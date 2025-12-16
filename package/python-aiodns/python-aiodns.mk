################################################################################
#
# python-aiodns
#
################################################################################

PYTHON_AIODNS_VERSION = 3.6.1
PYTHON_AIODNS_SOURCE = aiodns-$(PYTHON_AIODNS_VERSION).tar.gz
PYTHON_AIODNS_SITE = https://files.pythonhosted.org/packages/85/2f/9d1ee4f937addda60220f47925dac6c6b3782f6851fd578987284a8d2491
PYTHON_AIODNS_SETUP_TYPE = setuptools
PYTHON_AIODNS_LICENSE = MIT
PYTHON_AIODNS_LICENSE_FILES = LICENSE

$(eval $(python-package))
