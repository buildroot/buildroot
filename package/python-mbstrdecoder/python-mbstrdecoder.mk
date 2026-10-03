################################################################################
#
# python-mbstrdecoder
#
################################################################################

PYTHON_MBSTRDECODER_VERSION = 1.1.5
PYTHON_MBSTRDECODER_SOURCE = mbstrdecoder-$(PYTHON_MBSTRDECODER_VERSION).tar.gz
PYTHON_MBSTRDECODER_SITE = https://files.pythonhosted.org/packages/4b/9c/dd6e38d747a62ead27f9abef32f4ca4311d4e40ac28e76bcc9ffb5dd0329
PYTHON_MBSTRDECODER_SETUP_TYPE = setuptools
PYTHON_MBSTRDECODER_LICENSE = MIT
PYTHON_MBSTRDECODER_LICENSE_FILES = LICENSE
PYTHON_MBSTRDECODER_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
