################################################################################
#
# python-pytablewriter
#
################################################################################

PYTHON_PYTABLEWRITER_VERSION = 1.2.1
PYTHON_PYTABLEWRITER_SOURCE = pytablewriter-$(PYTHON_PYTABLEWRITER_VERSION).tar.gz
PYTHON_PYTABLEWRITER_SITE = https://files.pythonhosted.org/packages/f6/a1/617730f290f04d347103ab40bf67d317df6691b14746f6e1ea039fb57062
PYTHON_PYTABLEWRITER_SETUP_TYPE = setuptools
PYTHON_PYTABLEWRITER_LICENSE = MIT
PYTHON_PYTABLEWRITER_LICENSE_FILES = LICENSE
PYTHON_PYTABLEWRITER_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
