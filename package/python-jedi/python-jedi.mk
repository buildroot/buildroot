################################################################################
#
# python-jedi
#
################################################################################

PYTHON_JEDI_VERSION = 0.18.2
PYTHON_JEDI_SOURCE = jedi-$(PYTHON_JEDI_VERSION).tar.gz
PYTHON_JEDI_SITE = https://files.pythonhosted.org/packages/15/02/afd43c5066de05f6b3188f3aa74136a3289e6c30e7a45f351546cab0928c
PYTHON_JEDI_SETUP_TYPE = setuptools
PYTHON_JEDI_LICENSE = MIT, Apache-2.0 (typeshed)
PYTHON_JEDI_LICENSE_FILES = LICENSE.txt jedi/third_party/django-stubs/LICENSE.txt jedi/third_party/typeshed/LICENSE

$(eval $(python-package))
