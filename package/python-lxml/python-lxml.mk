################################################################################
#
# python-lxml
#
################################################################################

PYTHON_LXML_VERSION = 5.3.0
PYTHON_LXML_SITE = https://files.pythonhosted.org/packages/e7/6b/20c3a4b24751377aaa6307eb230b66701024012c29dd374999cc92983269
PYTHON_LXML_SOURCE = lxml-$(PYTHON_LXML_VERSION).tar.gz

# Not including the GPL, because it is used only for the test scripts.
PYTHON_LXML_LICENSE = BSD-3-Clause, Others
PYTHON_LXML_LICENSE_FILES = \
	LICENSES.txt \
	doc/licenses/BSD.txt \
	doc/licenses/elementtree.txt \
	src/lxml/isoschematron/resources/rng/iso-schematron.rng
PYTHON_LXML_CPE_ID_VENDOR = lxml
PYTHON_LXML_CPE_ID_PRODUCT = lxml

# python-lxml can use either setuptools, or distutils as a fallback.
# So, we use setuptools.
PYTHON_LXML_SETUP_TYPE = setuptools

PYTHON_LXML_DEPENDENCIES = libxml2 libxslt zlib
HOST_PYTHON_LXML_DEPENDENCIES = host-libxml2 host-libxslt host-zlib

# python-lxml needs these scripts in order to properly detect libxml2 and
# libxslt compiler and linker flags
PYTHON_LXML_BUILD_OPTS = \
	--skip-dependency-check \
	-C--build-option=--with-xslt-config=$(STAGING_DIR)/usr/bin/xslt-config \
	-C--build-option=--with-xml2-config=$(STAGING_DIR)/usr/bin/xml2-config
HOST_PYTHON_LXML_BUILD_OPTS = \
	--skip-dependency-check \
	-C--build-option=--with-xslt-config=$(HOST_DIR)/bin/xslt-config \
	-C--build-option=--with-xml2-config=$(HOST_DIR)/bin/xml2-config

$(eval $(python-package))
$(eval $(host-python-package))
