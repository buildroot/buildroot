################################################################################
#
# python-yatl
#
################################################################################

PYTHON_YATL_VERSION = 20210326.1
PYTHON_YATL_SOURCE = yatl-$(PYTHON_YATL_VERSION).tar.gz
PYTHON_YATL_SITE = https://files.pythonhosted.org/packages/9d/76/5906d641f452dc2ee56795e2152dafc1d212cd411d1cb893af29a7d06e33
PYTHON_YATL_SETUP_TYPE = setuptools
PYTHON_YATL_LICENSE = BSD-3-Clause

$(eval $(python-package))
$(eval $(host-python-package))
