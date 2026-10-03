################################################################################
#
# python-aiohappyeyeballs
#
################################################################################

PYTHON_AIOHAPPYEYEBALLS_VERSION = 2.7.1
PYTHON_AIOHAPPYEYEBALLS_SOURCE = aiohappyeyeballs-$(PYTHON_AIOHAPPYEYEBALLS_VERSION).tar.gz
PYTHON_AIOHAPPYEYEBALLS_SITE = https://files.pythonhosted.org/packages/ce/f4/eec0465c2f67b2664688d0240b3212d5196fd89e741df67ddb81f8d35658
PYTHON_AIOHAPPYEYEBALLS_SETUP_TYPE = poetry
PYTHON_AIOHAPPYEYEBALLS_LICENSE = PSF-2.0
PYTHON_AIOHAPPYEYEBALLS_LICENSE_FILES = LICENSE

$(eval $(python-package))
