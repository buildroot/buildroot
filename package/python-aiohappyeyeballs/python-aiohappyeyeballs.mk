################################################################################
#
# python-aiohappyeyeballs
#
################################################################################

PYTHON_AIOHAPPYEYEBALLS_VERSION = 2.6.1
PYTHON_AIOHAPPYEYEBALLS_SOURCE = aiohappyeyeballs-$(PYTHON_AIOHAPPYEYEBALLS_VERSION).tar.gz
PYTHON_AIOHAPPYEYEBALLS_SITE = https://files.pythonhosted.org/packages/26/30/f84a107a9c4331c14b2b586036f40965c128aa4fee4dda5d3d51cb14ad54
PYTHON_AIOHAPPYEYEBALLS_SETUP_TYPE = poetry
PYTHON_AIOHAPPYEYEBALLS_LICENSE = PSF-2.0
PYTHON_AIOHAPPYEYEBALLS_LICENSE_FILES = LICENSE

$(eval $(python-package))
