################################################################################
#
# python-aiojobs
#
################################################################################

PYTHON_AIOJOBS_VERSION = 1.2.1
PYTHON_AIOJOBS_SOURCE = aiojobs-$(PYTHON_AIOJOBS_VERSION).tar.gz
PYTHON_AIOJOBS_SITE = https://files.pythonhosted.org/packages/07/ad/e4240f9225022798e0e651ced8f6dc022e88eae4f2df6e1482a8f3c0d54d
PYTHON_AIOJOBS_SETUP_TYPE = setuptools
PYTHON_AIOJOBS_LICENSE = Apache-2.0
PYTHON_AIOJOBS_LICENSE_FILES = LICENSE

$(eval $(python-package))
