################################################################################
#
# python-jedi
#
################################################################################

PYTHON_JEDI_VERSION = 0.19.2
PYTHON_JEDI_SOURCE = jedi-$(PYTHON_JEDI_VERSION).tar.gz
PYTHON_JEDI_SITE = https://files.pythonhosted.org/packages/72/3a/79a912fbd4d8dd6fbb02bf69afd3bb72cf0c729bb3063c6f4498603db17a
PYTHON_JEDI_SETUP_TYPE = setuptools
PYTHON_JEDI_LICENSE = MIT, Apache-2.0 (typeshed)
PYTHON_JEDI_LICENSE_FILES = LICENSE.txt jedi/third_party/django-stubs/LICENSE.txt jedi/third_party/typeshed/LICENSE

$(eval $(python-package))
