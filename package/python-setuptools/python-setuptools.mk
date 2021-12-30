################################################################################
#
# python-setuptools
#
################################################################################

# For the target variant, we adapt the version depending on whether
# Python 3.x or 2.x is selected for the target.
ifeq ($(BR2_PACKAGE_PYTHON3),y)
# Please keep in sync with
# package/python3-setuptools/python3-setuptools.mk
PYTHON_SETUPTOOLS_VERSION = 59.8.0
PYTHON_SETUPTOOLS_SOURCE = setuptools-$(PYTHON3_SETUPTOOLS_VERSION).tar.gz
PYTHON_SETUPTOOLS_SITE = https://files.pythonhosted.org/packages/ef/75/2bc7bef4d668f9caa9c6ed3f3187989922765403198243040d08d2a52725
else # Python
PYTHON_SETUPTOOLS_VERSION = 44.0.0
PYTHON_SETUPTOOLS_SOURCE = setuptools-$(PYTHON_SETUPTOOLS_VERSION).zip
PYTHON_SETUPTOOLS_SITE = https://files.pythonhosted.org/packages/b0/f3/44da7482ac6da3f36f68e253cb04de37365b3dba9036a3c70773b778b485
endif

# The host variant is only for Python 2.x, so we need to use 44.0.0.
HOST_PYTHON_SETUPTOOLS_VERSION = 44.0.0
HOST_PYTHON_SETUPTOOLS_SOURCE = setuptools-$(HOST_PYTHON_SETUPTOOLS_VERSION).zip
HOST_PYTHON_SETUPTOOLS_SITE = https://files.pythonhosted.org/packages/b0/f3/44da7482ac6da3f36f68e253cb04de37365b3dba9036a3c70773b778b485
HOST_PYTHON_SETUPTOOLS_NEEDS_HOST_PYTHON = python2

PYTHON_SETUPTOOLS_LICENSE = MIT
PYTHON_SETUPTOOLS_LICENSE_FILES = LICENSE
PYTHON_SETUPTOOLS_CPE_ID_VENDOR = python
PYTHON_SETUPTOOLS_CPE_ID_PRODUCT = setuptools
PYTHON_SETUPTOOLS_SETUP_TYPE = setuptools

ifeq ($(BR2_PACKAGE_PYTHON),y)
define PYTHON_SETUPTOOLS_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(PYTHON_SETUPTOOLS_DL_DIR)/$(PYTHON_SETUPTOOLS_SOURCE)
	mv $(@D)/setuptools-$(PYTHON_SETUPTOOLS_VERSION)/* $(@D)
	$(RM) -r $(@D)/setuptools-$(PYTHON_SETUPTOOLS_VERSION)
endef
endif

define HOST_PYTHON_SETUPTOOLS_EXTRACT_CMDS
	$(UNZIP) -d $(@D) $(HOST_PYTHON_SETUPTOOLS_DL_DIR)/$(HOST_PYTHON_SETUPTOOLS_SOURCE)
	mv $(@D)/setuptools-$(HOST_PYTHON_SETUPTOOLS_VERSION)/* $(@D)
	$(RM) -r $(@D)/setuptools-$(HOST_PYTHON_SETUPTOOLS_VERSION)
endef

$(eval $(python-package))
$(eval $(host-python-package))
