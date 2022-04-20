################################################################################
#
# python-fonttools
#
################################################################################

PYTHON_FONTTOOLS_VERSION = 4.32.0
PYTHON_FONTTOOLS_SOURCE = fonttools-$(PYTHON_FONTTOOLS_VERSION).zip
PYTHON_FONTTOOLS_SITE = https://files.pythonhosted.org/packages/88/27/418ac6f1b85856608df81fe6e72fbb85929d7b904540056f3061e27bba04
PYTHON_FONTTOOLS_SETUP_TYPE = setuptools
PYTHON_FONTTOOLS_LICENSE = MIT
PYTHON_FONTTOOLS_LICENSE_FILES = LICENSE
PYTHON_FONTTOOLS_DEPENDENCIES = host-python-cython
PYTHON_FONTTOOLS_ENV = FONTTOOLS_WITH_CYTHON=1

define PYTHON_FONTTOOLS_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(PYTHON_FONTTOOLS_DL_DIR)/$(PYTHON_FONTTOOLS_SOURCE)
	mv $(@D)/fonttools-$(PYTHON_FONTTOOLS_VERSION)/* $(@D)
	$(RM) -r $(@D)/fonttools-$(PYTHON_FONTTOOLS_VERSION)
endef

$(eval $(python-package))
