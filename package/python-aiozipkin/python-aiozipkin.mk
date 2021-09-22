################################################################################
#
# python-aiozipkin
#
################################################################################

PYTHON_AIOZIPKIN_VERSION = 1.1.0
PYTHON_AIOZIPKIN_SOURCE = aiozipkin-$(PYTHON_AIOZIPKIN_VERSION).tar.gz
PYTHON_AIOZIPKIN_SITE = https://files.pythonhosted.org/packages/0a/46/5f328fb8163163f0d4401a1c07585cdf567e56305cb12ce54c9bb62e3f74
PYTHON_AIOZIPKIN_SETUP_TYPE = setuptools
PYTHON_AIOZIPKIN_LICENSE = Apache-2.0
PYTHON_AIOZIPKIN_LICENSE_FILES = LICENSE

$(eval $(python-package))
