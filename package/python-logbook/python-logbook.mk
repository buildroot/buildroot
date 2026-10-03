################################################################################
#
# python-logbook
#
################################################################################

PYTHON_LOGBOOK_VERSION = 1.10.1
PYTHON_LOGBOOK_SOURCE_PYPI = logbook-$(PYTHON_LOGBOOK_VERSION).tar.gz
PYTHON_LOGBOOK_SITE_PYPI = https://files.pythonhosted.org/packages/75/73/2998c9192466f93a63d325866d7c3e3800403ccc49ba9f7dc6bd89963873
PYTHON_LOGBOOK_SITE = $(PYTHON_LOGBOOK_SITE_PYPI)/$(PYTHON_LOGBOOK_SOURCE_PYPI)?buildroot-path=filename
PYTHON_LOGBOOK_SETUP_TYPE = setuptools-rust
PYTHON_LOGBOOK_LICENSE = BSD-3-Clause
PYTHON_LOGBOOK_LICENSE_FILES = LICENSE

$(eval $(python-package))
