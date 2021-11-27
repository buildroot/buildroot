################################################################################
#
# python-zopfli
#
################################################################################

PYTHON_ZOPFLI_VERSION = 0.1.9
PYTHON_ZOPFLI_SOURCE = zopfli-$(PYTHON_ZOPFLI_VERSION).zip
PYTHON_ZOPFLI_SITE = https://files.pythonhosted.org/packages/10/7d/278fd896401b0ef76e06cd42c3ce1541572d83b1c713b6786795c60a1bbe
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
