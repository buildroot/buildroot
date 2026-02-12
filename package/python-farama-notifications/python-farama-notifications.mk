################################################################################
#
# python-farama-notifications
#
################################################################################

PYTHON_FARAMA_NOTIFICATIONS_VERSION = 0.0.4
PYTHON_FARAMA_NOTIFICATIONS_SOURCE = Farama-Notifications-$(PYTHON_FARAMA_NOTIFICATIONS_VERSION).tar.gz
PYTHON_FARAMA_NOTIFICATIONS_SITE = https://files.pythonhosted.org/packages/2e/2c/8384832b7a6b1fd6ba95bbdcae26e7137bb3eedc955c42fd5cdcc086cfbf
PYTHON_FARAMA_NOTIFICATIONS_SETUP_TYPE = setuptools
PYTHON_FARAMA_NOTIFICATIONS_LICENSE = MIT
PYTHON_FARAMA_NOTIFICATIONS_LICENSE_FILES = LICENSE

$(eval $(python-package))
