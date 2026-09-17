################################################################################
#
# python-annotated-doc
#
################################################################################

PYTHON_ANNOTATED_DOC_VERSION = 0.0.5
PYTHON_ANNOTATED_DOC_SOURCE = annotated_doc-$(PYTHON_ANNOTATED_DOC_VERSION).tar.gz
PYTHON_ANNOTATED_DOC_SITE = https://files.pythonhosted.org/packages/5a/8e/38aa427ed5402449e226975b649c5dc73ccadfefeb95e6aecb8f8ea4b6b6
PYTHON_ANNOTATED_DOC_SETUP_TYPE = pep517
PYTHON_ANNOTATED_DOC_LICENSE = MIT
PYTHON_ANNOTATED_DOC_LICENSE_FILES = LICENSE
PYTHON_ANNOTATED_DOC_DEPENDENCIES = host-python-pdm-backend

$(eval $(python-package))
