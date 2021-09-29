################################################################################
#
# python-typing
#
################################################################################

PYTHON_TYPING_VERSION = 3.10.0.0
PYTHON_TYPING_SOURCE = typing-$(PYTHON_TYPING_VERSION).tar.gz
PYTHON_TYPING_SITE = https://files.pythonhosted.org/packages/b0/1b/835d4431805939d2996f8772aca1d2313a57e8860fec0e48e8e7dfe3a477
PYTHON_TYPING_SETUP_TYPE = setuptools
PYTHON_TYPING_LICENSE = Python-2.0, others
PYTHON_TYPING_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
