################################################################################
#
# python-email-validator
#
################################################################################

PYTHON_EMAIL_VALIDATOR_VERSION = 2.1.1
PYTHON_EMAIL_VALIDATOR_SOURCE = email_validator-$(PYTHON_EMAIL_VALIDATOR_VERSION).tar.gz
PYTHON_EMAIL_VALIDATOR_SITE = https://files.pythonhosted.org/packages/63/82/2914bff80ebee8c027802a664ad4b4caad502cd594e358f76aff395b5e56
PYTHON_EMAIL_VALIDATOR_SETUP_TYPE = setuptools
PYTHON_EMAIL_VALIDATOR_LICENSE = Unlicense
PYTHON_EMAIL_VALIDATOR_LICENSE_FILES = LICENSE

$(eval $(python-package))
