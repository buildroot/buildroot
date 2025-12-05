################################################################################
#
# python-annotated-doc
#
################################################################################

PYTHON_ANNOTATED_DOC_VERSION = 0.0.4
PYTHON_ANNOTATED_DOC_SOURCE = annotated_doc-$(PYTHON_ANNOTATED_DOC_VERSION).tar.gz
PYTHON_ANNOTATED_DOC_SITE = https://files.pythonhosted.org/packages/57/ba/046ceea27344560984e26a590f90bc7f4a75b06701f653222458922b558c
PYTHON_ANNOTATED_DOC_SETUP_TYPE = pep517
PYTHON_ANNOTATED_DOC_LICENSE = MIT
PYTHON_ANNOTATED_DOC_LICENSE_FILES = LICENSE
PYTHON_ANNOTATED_DOC_DEPENDENCIES = host-python-pdm-backend

$(eval $(python-package))
