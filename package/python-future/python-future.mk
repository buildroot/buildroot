################################################################################
#
# python-future
#
################################################################################

PYTHON_FUTURE_VERSION = 0.18.3
PYTHON_FUTURE_SOURCE = future-$(PYTHON_FUTURE_VERSION).tar.gz
PYTHON_FUTURE_SITE = https://files.pythonhosted.org/packages/8f/2e/cf6accf7415237d6faeeebdc7832023c90e0282aa16fd3263db0eb4715ec
PYTHON_FUTURE_SETUP_TYPE = setuptools
PYTHON_FUTURE_LICENSE = MIT
PYTHON_FUTURE_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
