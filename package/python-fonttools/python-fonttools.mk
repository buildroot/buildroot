################################################################################
#
# python-fonttools
#
################################################################################

PYTHON_FONTTOOLS_VERSION = 4.28.2
PYTHON_FONTTOOLS_SOURCE = fonttools-$(PYTHON_FONTTOOLS_VERSION).zip
PYTHON_FONTTOOLS_SITE = https://files.pythonhosted.org/packages/3c/d5/f722e0d1aed0d547383913c6bc3c4ff35772952057b8e2b8fe3be8df4216
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
