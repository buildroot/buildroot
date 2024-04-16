################################################################################
#
# python-jedi
#
################################################################################

PYTHON_JEDI_VERSION = 0.19.1
PYTHON_JEDI_SOURCE = jedi-$(PYTHON_JEDI_VERSION).tar.gz
PYTHON_JEDI_SITE = https://files.pythonhosted.org/packages/d6/99/99b493cec4bf43176b678de30f81ed003fd6a647a301b9c927280c600f0a
PYTHON_JEDI_SETUP_TYPE = setuptools
PYTHON_JEDI_LICENSE = MIT, Apache-2.0 (typeshed)
PYTHON_JEDI_LICENSE_FILES = LICENSE.txt jedi/third_party/django-stubs/LICENSE.txt jedi/third_party/typeshed/LICENSE

$(eval $(python-package))
