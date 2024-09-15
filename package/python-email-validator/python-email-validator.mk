################################################################################
#
# python-email-validator
#
################################################################################

PYTHON_EMAIL_VALIDATOR_VERSION = 2.2.0
PYTHON_EMAIL_VALIDATOR_SOURCE = email_validator-$(PYTHON_EMAIL_VALIDATOR_VERSION).tar.gz
PYTHON_EMAIL_VALIDATOR_SITE = https://files.pythonhosted.org/packages/48/ce/13508a1ec3f8bb981ae4ca79ea40384becc868bfae97fd1c942bb3a001b1
PYTHON_EMAIL_VALIDATOR_SETUP_TYPE = setuptools
PYTHON_EMAIL_VALIDATOR_LICENSE = Unlicense
PYTHON_EMAIL_VALIDATOR_LICENSE_FILES = LICENSE

$(eval $(python-package))
