################################################################################
#
# python-aioredis
#
################################################################################

PYTHON_AIOREDIS_VERSION = 2.0.1
PYTHON_AIOREDIS_SOURCE = aioredis-$(PYTHON_AIOREDIS_VERSION).tar.gz
PYTHON_AIOREDIS_SITE = https://files.pythonhosted.org/packages/2e/cf/9eb144a0b05809ffc5d29045c4b51039000ea275bc1268d0351c9e7dfc06
PYTHON_AIOREDIS_SETUP_TYPE = setuptools
PYTHON_AIOREDIS_LICENSE = MIT
PYTHON_AIOREDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
