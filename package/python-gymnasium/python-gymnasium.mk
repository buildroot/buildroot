################################################################################
#
# python-gymnasium
#
################################################################################

PYTHON_GYMNASIUM_VERSION = 1.3.0
PYTHON_GYMNASIUM_SOURCE = gymnasium-$(PYTHON_GYMNASIUM_VERSION).tar.gz
PYTHON_GYMNASIUM_SITE = https://files.pythonhosted.org/packages/4d/ff/14b6880d703dfaca204490979d3254ccd280c99550798993319902873658
PYTHON_GYMNASIUM_SETUP_TYPE = setuptools
PYTHON_GYMNASIUM_LICENSE = MIT
PYTHON_GYMNASIUM_LICENSE_FILES = LICENSE

$(eval $(python-package))
