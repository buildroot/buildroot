################################################################################
#
# python-fonttools
#
################################################################################

PYTHON_FONTTOOLS_VERSION = 4.28.5
PYTHON_FONTTOOLS_SOURCE = fonttools-$(PYTHON_FONTTOOLS_VERSION).zip
PYTHON_FONTTOOLS_SITE = https://files.pythonhosted.org/packages/ce/1b/d4cd86f4e6cbd54a3c4f807015b116299bcd6d6587ea0645d88ba9d932bb
PYTHON_FONTTOOLS_SETUP_TYPE = setuptools
PYTHON_FONTTOOLS_LICENSE = MIT
PYTHON_FONTTOOLS_LICENSE_FILES = LICENSE
PYTHON_FONTTOOLS_DEPENDENCIES = host-python3-cython
PYTHON_FONTTOOLS_ENV = FONTTOOLS_WITH_CYTHON=1

define PYTHON_FONTTOOLS_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(PYTHON_FONTTOOLS_DL_DIR)/$(PYTHON_FONTTOOLS_SOURCE)
	mv $(@D)/fonttools-$(PYTHON_FONTTOOLS_VERSION)/* $(@D)
	$(RM) -r $(@D)/fonttools-$(PYTHON_FONTTOOLS_VERSION)
endef

$(eval $(python-package))
