################################################################################
#
# python-aiohappyeyeballs
#
################################################################################

PYTHON_AIOHAPPYEYEBALLS_VERSION = 2.4.4
PYTHON_AIOHAPPYEYEBALLS_SOURCE = aiohappyeyeballs-$(PYTHON_AIOHAPPYEYEBALLS_VERSION).tar.gz
PYTHON_AIOHAPPYEYEBALLS_SITE = https://files.pythonhosted.org/packages/7f/55/e4373e888fdacb15563ef6fa9fa8c8252476ea071e96fb46defac9f18bf2
PYTHON_AIOHAPPYEYEBALLS_SETUP_TYPE = poetry
PYTHON_AIOHAPPYEYEBALLS_LICENSE = PSF-2.0
PYTHON_AIOHAPPYEYEBALLS_LICENSE_FILES = LICENSE

$(eval $(python-package))
