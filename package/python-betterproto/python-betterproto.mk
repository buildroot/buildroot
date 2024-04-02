################################################################################
#
# python-betterproto
#
################################################################################

PYTHON_BETTERPROTO_VERSION = 2.0.0b6
PYTHON_BETTERPROTO_SOURCE = betterproto-$(PYTHON_BETTERPROTO_VERSION).tar.gz
PYTHON_BETTERPROTO_SITE = https://files.pythonhosted.org/packages/45/43/4c44efd75f2ef48a16b458c2fe2cff7aa74bab8fcadf2653bb5110a87f97
PYTHON_BETTERPROTO_SETUP_TYPE = pep517
PYTHON_BETTERPROTO_LICENSE = MIT
PYTHON_BETTERPROTO_LICENSE_FILES = LICENSE.md
PYTHON_BETTERPROTO_DEPENDENCIES = host-python-poetry-core

$(eval $(python-package))
