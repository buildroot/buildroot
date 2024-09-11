################################################################################
#
# python-aiohappyeyeballs
#
################################################################################

PYTHON_AIOHAPPYEYEBALLS_VERSION = 2.4.0
PYTHON_AIOHAPPYEYEBALLS_SOURCE = aiohappyeyeballs-$(PYTHON_AIOHAPPYEYEBALLS_VERSION).tar.gz
PYTHON_AIOHAPPYEYEBALLS_SITE = https://files.pythonhosted.org/packages/2d/f7/22bba300a16fd1cad99da1a23793fe43963ee326d012fdf852d0b4035955
PYTHON_AIOHAPPYEYEBALLS_SETUP_TYPE = pep517
PYTHON_AIOHAPPYEYEBALLS_LICENSE = PSF-2.0
PYTHON_AIOHAPPYEYEBALLS_LICENSE_FILES = LICENSE
PYTHON_AIOHAPPYEYEBALLS_DEPENDENCIES = host-python-poetry-core

$(eval $(python-package))
