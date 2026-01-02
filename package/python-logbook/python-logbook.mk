################################################################################
#
# python-logbook
#
################################################################################

PYTHON_LOGBOOK_VERSION = 1.9.2
PYTHON_LOGBOOK_SOURCE_PYPI = logbook-$(PYTHON_LOGBOOK_VERSION).tar.gz
PYTHON_LOGBOOK_SITE_PYPI = https://files.pythonhosted.org/packages/f2/cf/e39c249003caaa7f84e2b00c11c7423892d525f8136ff349f9914914a744
PYTHON_LOGBOOK_SITE = $(PYTHON_LOGBOOK_SITE_PYPI)/$(PYTHON_LOGBOOK_SOURCE_PYPI)?buildroot-path=filename
PYTHON_LOGBOOK_SETUP_TYPE = setuptools-rust
PYTHON_LOGBOOK_LICENSE = BSD-3-Clause
PYTHON_LOGBOOK_LICENSE_FILES = LICENSE

$(eval $(python-package))
