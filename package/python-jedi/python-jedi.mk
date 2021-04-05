################################################################################
#
# python-jedi
#
################################################################################

PYTHON_JEDI_VERSION = 0.18.0
PYTHON_JEDI_SOURCE = jedi-$(PYTHON_JEDI_VERSION).tar.gz
PYTHON_JEDI_SITE = https://files.pythonhosted.org/packages/ac/11/5c542bf206efbae974294a61febc61e09d74cb5d90d8488793909db92537
PYTHON_JEDI_SETUP_TYPE = setuptools
PYTHON_JEDI_LICENSE = MIT, Apache-2.0 (typeshed)
PYTHON_JEDI_LICENSE_FILES = LICENSE.txt jedi/third_party/django-stubs/LICENSE.txt jedi/third_party/typeshed/LICENSE

$(eval $(python-package))
