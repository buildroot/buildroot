################################################################################
#
# python-logstash
#
################################################################################

PYTHON_LOGSTASH_VERSION = 0.4.8
PYTHON_LOGSTASH_SITE = https://files.pythonhosted.org/packages/f7/3b/c3a957bbdd23859f07905fc3d1adfe89957217a347478c58409f0315cf1d
PYTHON_LOGSTASH_SETUP_TYPE = setuptools
PYTHON_LOGSTASH_LICENSE = MIT
PYTHON_LOGSTASH_LICENSE_FILES = LICENSE

$(eval $(python-package))
