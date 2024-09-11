################################################################################
#
# python-aiojobs
#
################################################################################

PYTHON_AIOJOBS_VERSION = 1.3.0
PYTHON_AIOJOBS_SOURCE = aiojobs-$(PYTHON_AIOJOBS_VERSION).tar.gz
PYTHON_AIOJOBS_SITE = https://files.pythonhosted.org/packages/c4/0b/d612a769c28bd22bcc52b369a9a10c63eb6e7b5e2e0cfb35e3be7357fe29
PYTHON_AIOJOBS_SETUP_TYPE = setuptools
PYTHON_AIOJOBS_LICENSE = Apache-2.0
PYTHON_AIOJOBS_LICENSE_FILES = LICENSE

$(eval $(python-package))
