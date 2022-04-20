################################################################################
#
# python-zopfli
#
################################################################################

PYTHON_ZOPFLI_VERSION = 0.2.1
PYTHON_ZOPFLI_SOURCE = zopfli-$(PYTHON_ZOPFLI_VERSION).zip
PYTHON_ZOPFLI_SITE = https://files.pythonhosted.org/packages/91/25/ba6f370e18359292f05ca4df93642eb7d1c424721ef61f61b8610a63d0c5
PYTHON_ZOPFLI_SETUP_TYPE = setuptools
PYTHON_ZOPFLI_LICENSE = Apache-2.0
PYTHON_ZOPFLI_LICENSE_FILES = COPYING
PYTHON_ZOPFLI_DEPENDENCIES = host-python-setuptools-scm

define PYTHON_ZOPFLI_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(PYTHON_ZOPFLI_DL_DIR)/$(PYTHON_ZOPFLI_SOURCE)
	mv $(@D)/zopfli-$(PYTHON_ZOPFLI_VERSION)/* $(@D)
	$(RM) -r $(@D)/zopfli-$(PYTHON_ZOPFLI_VERSION)
endef

$(eval $(python-package))
