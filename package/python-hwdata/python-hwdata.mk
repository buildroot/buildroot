################################################################################
#
# python-hwdata
#
################################################################################

PYTHON_HWDATA_VERSION = 2.3.7
PYTHON_HWDATA_SOURCE = hwdata-$(PYTHON_HWDATA_VERSION).tar.gz
PYTHON_HWDATA_SITE = https://files.pythonhosted.org/packages/15/26/f5bc1b42129fbcbd1c99c29714af1685fc89e2cf37680a9930d4fcac1808
PYTHON_HWDATA_SETUP_TYPE = distutils
PYTHON_HWDATA_LICENSE = GPL-2.0+
PYTHON_HWDATA_LICENSE_FILES = LICENSE

# There is no LICENSE file in the PyPi tarball, but it is available in
# upstream git repository:
PYTHON_HWDATA_EXTRA_DOWNLOADS = https://raw.githubusercontent.com/xsuchy/python-hwdata/python-hwdata-$(PYTHON_HWDATA_VERSION)-1/LICENSE

define PYTHON_HWDATA_ADD_LICENSE_FILE
	cp $(PYTHON_HWDATA_DL_DIR)/LICENSE $(@D)
endef
PYTHON_HWDATA_POST_EXTRACT_HOOKS += PYTHON_HWDATA_ADD_LICENSE_FILE

$(eval $(python-package))
