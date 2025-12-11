################################################################################
#
# python-dnspython
#
################################################################################

PYTHON_DNSPYTHON_VERSION = 2.8.0
PYTHON_DNSPYTHON_SOURCE = dnspython-$(PYTHON_DNSPYTHON_VERSION).tar.gz
PYTHON_DNSPYTHON_SITE = https://files.pythonhosted.org/packages/8c/8b/57666417c0f90f08bcafa776861060426765fdb422eb10212086fb811d26
PYTHON_DNSPYTHON_LICENSE = ISC
PYTHON_DNSPYTHON_LICENSE_FILES = LICENSE
PYTHON_DNSPYTHON_SETUP_TYPE = hatch

$(eval $(python-package))
$(eval $(host-python-package))
