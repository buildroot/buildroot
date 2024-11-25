################################################################################
#
# python-mwscrape2slob
#
################################################################################

PYTHON_MWSCRAPE2SLOB_VERSION = 69eb1c90d2cce75cb91601763bcf8fad8ff8366d
PYTHON_MWSCRAPE2SLOB_SITE = $(call github,itkach,mwscrape2slob,$(PYTHON_MWSCRAPE2SLOB_VERSION))
PYTHON_MWSCRAPE2SLOB_LICENSE = GPL-3.0, Apache-2.0 (MathJax), GPL (MediaWiki monobook style sheet)
PYTHON_MWSCRAPE2SLOB_SETUP_TYPE = setuptools

$(eval $(python-package))
