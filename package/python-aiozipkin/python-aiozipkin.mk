################################################################################
#
# python-aiozipkin
#
################################################################################

PYTHON_AIOZIPKIN_VERSION = 1.1.1
PYTHON_AIOZIPKIN_SOURCE = aiozipkin-$(PYTHON_AIOZIPKIN_VERSION).tar.gz
PYTHON_AIOZIPKIN_SITE = https://files.pythonhosted.org/packages/f2/fe/26a60a7c9e91c968eac5dacab2948ed931a676880a6878695ff281c72b8f
PYTHON_AIOZIPKIN_SETUP_TYPE = setuptools
PYTHON_AIOZIPKIN_LICENSE = Apache-2.0
PYTHON_AIOZIPKIN_LICENSE_FILES = LICENSE

$(eval $(python-package))
