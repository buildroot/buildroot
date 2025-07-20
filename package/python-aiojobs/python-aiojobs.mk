################################################################################
#
# python-aiojobs
#
################################################################################

PYTHON_AIOJOBS_VERSION = 1.4.0
PYTHON_AIOJOBS_SOURCE = aiojobs-$(PYTHON_AIOJOBS_VERSION).tar.gz
PYTHON_AIOJOBS_SITE = https://files.pythonhosted.org/packages/03/54/751969398e2039b4dc458fa153dc066a0f7337a5b480d58944f59b7b38ae
PYTHON_AIOJOBS_SETUP_TYPE = setuptools
PYTHON_AIOJOBS_LICENSE = Apache-2.0
PYTHON_AIOJOBS_LICENSE_FILES = LICENSE

$(eval $(python-package))
