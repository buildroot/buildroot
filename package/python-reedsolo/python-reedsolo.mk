################################################################################
#
# python-reedsolo
#
################################################################################

PYTHON_REEDSOLO_VERSION = 1.7.0
PYTHON_REEDSOLO_SOURCE = reedsolo-$(PYTHON_REEDSOLO_VERSION).tar.gz
PYTHON_REEDSOLO_SITE = https://files.pythonhosted.org/packages/f7/61/a67338cbecf370d464e71b10e9a31355f909d6937c3a8d6b17dd5d5beb5e
PYTHON_REEDSOLO_SETUP_TYPE = setuptools
PYTHON_REEDSOLO_LICENSE = MIT-0, Unlicense
PYTHON_REEDSOLO_LICENSE_FILES = LICENSE

$(eval $(python-package))
