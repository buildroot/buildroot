################################################################################
#
# python-mwscrape
#
################################################################################

PYTHON_MWSCRAPE_VERSION = 2e153faa678b90402ca87aa765f7d11386d7942c
PYTHON_MWSCRAPE_SITE = $(call github,itkach,mwscrape,$(PYTHON_MWSCRAPE_VERSION))
PYTHON_MWSCRAPE_LICENSE = MPL-2.0
PYTHON_MWSCRAPE_LICENSE_FILES = LICENSE.txt
PYTHON_MWSCRAPE_SETUP_TYPE = setuptools

$(eval $(python-package))
