################################################################################
#
# python-farama-notifications
#
################################################################################

PYTHON_FARAMA_NOTIFICATIONS_VERSION = 0.0.6
PYTHON_FARAMA_NOTIFICATIONS_SOURCE = farama_notifications-$(PYTHON_FARAMA_NOTIFICATIONS_VERSION).tar.gz
PYTHON_FARAMA_NOTIFICATIONS_SITE = https://files.pythonhosted.org/packages/ec/91/14397890dde30adc4bee6462158933806207bc5dd10d7b4d09d5c33845cf
PYTHON_FARAMA_NOTIFICATIONS_SETUP_TYPE = setuptools
PYTHON_FARAMA_NOTIFICATIONS_LICENSE = MIT
PYTHON_FARAMA_NOTIFICATIONS_LICENSE_FILES = LICENSE

$(eval $(python-package))
