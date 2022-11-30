################################################################################
#
# python-unittest-xml-reporting
#
################################################################################

PYTHON_UNITTEST_XML_REPORTING_VERSION = 3.0.4
PYTHON_UNITTEST_XML_REPORTING_SOURCE = unittest-xml-reporting-$(PYTHON_UNITTEST_XML_REPORTING_VERSION).tar.gz
PYTHON_UNITTEST_XML_REPORTING_SITE = https://files.pythonhosted.org/packages/bc/09/677086169c8e302b614de7d4a97c45c4446a382f31cc010fb31177258508
# License file missing in Pypi tarball, download separately. Issue
# reported at
# https://github.com/xmlrunner/unittest-xml-reporting/issues/259
PYTHON_UNITTEST_XML_REPORTING_EXTRA_DOWNLOADS = https://raw.githubusercontent.com/xmlrunner/unittest-xml-reporting/$(PYTHON_UNITTEST_XML_REPORTING_VERSION)/LICENSE
PYTHON_UNITTEST_XML_REPORTING_SETUP_TYPE = setuptools
PYTHON_UNITTEST_XML_REPORTING_LICENSE = BSD-2-Clause
PYTHON_UNITTEST_XML_REPORTING_LICENSE_FILES = LICENSE

define PYTHON_UNITTEST_XML_REPORTING_ADD_LICENSE_FILE
	$(INSTALL) -D -m 0644 $(PYTHON_UNITTEST_XML_REPORTING_DL_DIR)/LICENSE $(@D)/LICENSE
endef
PYTHON_UNITTEST_XML_REPORTING_POST_EXTRACT_HOOKS += PYTHON_UNITTEST_XML_REPORTING_ADD_LICENSE_FILE

$(eval $(python-package))
