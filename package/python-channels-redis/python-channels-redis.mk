################################################################################
#
# python-channels-redis
#
################################################################################

PYTHON_CHANNELS_REDIS_VERSION = 4.2.1
PYTHON_CHANNELS_REDIS_SOURCE = channels_redis-$(PYTHON_CHANNELS_REDIS_VERSION).tar.gz
PYTHON_CHANNELS_REDIS_SITE = https://files.pythonhosted.org/packages/c7/6d/c379c9feea4522cbdb4eba9b3d23a6270ba8cbd94e847b21834d898109d6
PYTHON_CHANNELS_REDIS_SETUP_TYPE = setuptools
PYTHON_CHANNELS_REDIS_LICENSE = BSD-3-Clause
PYTHON_CHANNELS_REDIS_LICENSE_FILES = LICENSE

$(eval $(python-package))
