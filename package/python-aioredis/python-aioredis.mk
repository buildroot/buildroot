################################################################################
#
# python-aioredis
#
################################################################################

PYTHON_AIOREDIS_VERSION = 2.0.0
PYTHON_AIOREDIS_SOURCE = aioredis-$(PYTHON_AIOREDIS_VERSION).tar.gz
PYTHON_AIOREDIS_SITE = https://files.pythonhosted.org/packages/92/60/a3cb5fadc254cc6e709ba14a02531870b02386b8c7bb147bf80a2be93f76
PYTHON_AIOREDIS_SETUP_TYPE = setuptools
PYTHON_AIOREDIS_LICENSE = MIT
PYTHON_AIOREDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
