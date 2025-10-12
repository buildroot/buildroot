################################################################################
#
# python-email-validator
#
################################################################################

PYTHON_EMAIL_VALIDATOR_VERSION = 2.3.0
PYTHON_EMAIL_VALIDATOR_SOURCE = email_validator-$(PYTHON_EMAIL_VALIDATOR_VERSION).tar.gz
PYTHON_EMAIL_VALIDATOR_SITE = https://files.pythonhosted.org/packages/f5/22/900cb125c76b7aaa450ce02fd727f452243f2e91a61af068b40adba60ea9
PYTHON_EMAIL_VALIDATOR_SETUP_TYPE = setuptools
PYTHON_EMAIL_VALIDATOR_LICENSE = Unlicense
PYTHON_EMAIL_VALIDATOR_LICENSE_FILES = LICENSE

$(eval $(python-package))
