################################################################################
#
# python-apscheduler
#
################################################################################

PYTHON_APSCHEDULER_VERSION = 3.11.3
PYTHON_APSCHEDULER_SOURCE = apscheduler-$(PYTHON_APSCHEDULER_VERSION).tar.gz
PYTHON_APSCHEDULER_SITE = https://files.pythonhosted.org/packages/8c/6b/eeff360196bb20b312c9e762a820fd1b2c6d809466c755ef57863478e454
PYTHON_APSCHEDULER_SETUP_TYPE = setuptools
PYTHON_APSCHEDULER_DEPENDENCIES = host-python-setuptools-scm
PYTHON_APSCHEDULER_LICENSE = MIT
PYTHON_APSCHEDULER_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
