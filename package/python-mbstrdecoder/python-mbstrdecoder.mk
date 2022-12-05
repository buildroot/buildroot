################################################################################
#
# python-mbstrdecoder
#
################################################################################

PYTHON_MBSTRDECODER_VERSION = 1.1.1
PYTHON_MBSTRDECODER_SOURCE = mbstrdecoder-$(PYTHON_MBSTRDECODER_VERSION).tar.gz
PYTHON_MBSTRDECODER_SITE = https://files.pythonhosted.org/packages/ba/ac/ba46bb6eb6165541ce25ff230469efe1c04043cf173f856dcc91876c38de
PYTHON_MBSTRDECODER_SETUP_TYPE = setuptools
PYTHON_MBSTRDECODER_LICENSE = MIT
PYTHON_MBSTRDECODER_LICENSE_FILES = LICENSE

$(eval $(python-package))
