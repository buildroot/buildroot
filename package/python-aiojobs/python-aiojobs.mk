################################################################################
#
# python-aiojobs
#
################################################################################

PYTHON_AIOJOBS_VERSION = 1.2.0
PYTHON_AIOJOBS_SOURCE = aiojobs-$(PYTHON_AIOJOBS_VERSION).tar.gz
PYTHON_AIOJOBS_SITE = https://files.pythonhosted.org/packages/c4/e0/4685393810a267c09edef41ddafd0dd28108d95e1b91019b1843fc6e5b83
PYTHON_AIOJOBS_SETUP_TYPE = setuptools
PYTHON_AIOJOBS_LICENSE = Apache-2.0
PYTHON_AIOJOBS_LICENSE_FILES = LICENSE

$(eval $(python-package))
