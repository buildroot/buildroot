################################################################################
#
# python-gymnasium
#
################################################################################

PYTHON_GYMNASIUM_VERSION = 1.2.3
PYTHON_GYMNASIUM_SOURCE = gymnasium-$(PYTHON_GYMNASIUM_VERSION).tar.gz
PYTHON_GYMNASIUM_SITE = https://files.pythonhosted.org/packages/76/59/653a9417d98ed3e29ef9734ba52c3495f6c6823b8d5c0c75369f25111708
PYTHON_GYMNASIUM_SETUP_TYPE = setuptools
PYTHON_GYMNASIUM_LICENSE = MIT
PYTHON_GYMNASIUM_LICENSE_FILES = LICENSE

$(eval $(python-package))
