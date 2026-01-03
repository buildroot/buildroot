################################################################################
#
# python-channels-redis
#
################################################################################

PYTHON_CHANNELS_REDIS_VERSION = 4.3.0
PYTHON_CHANNELS_REDIS_SOURCE = channels_redis-$(PYTHON_CHANNELS_REDIS_VERSION).tar.gz
PYTHON_CHANNELS_REDIS_SITE = https://files.pythonhosted.org/packages/ab/69/fd3407ad407a80e72ca53850eb7a4c306273e67d5bbb71a86d0e6d088439
PYTHON_CHANNELS_REDIS_SETUP_TYPE = setuptools
PYTHON_CHANNELS_REDIS_LICENSE = BSD-3-Clause
PYTHON_CHANNELS_REDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
