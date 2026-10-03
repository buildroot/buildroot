################################################################################
#
# python-gunicorn
#
################################################################################

PYTHON_GUNICORN_VERSION = 26.2.0
PYTHON_GUNICORN_SOURCE = gunicorn-$(PYTHON_GUNICORN_VERSION).tar.gz
PYTHON_GUNICORN_SITE = https://files.pythonhosted.org/packages/d9/8a/e4ef6ee11701b6cd64702848415ffb69eeff85cb388a3c6c7fe86f22f3f8
PYTHON_GUNICORN_SETUP_TYPE = setuptools
PYTHON_GUNICORN_LICENSE = MIT
PYTHON_GUNICORN_LICENSE_FILES = LICENSE
PYTHON_GUNICORN_CPE_ID_VENDOR = gunicorn
PYTHON_GUNICORN_CPE_ID_PRODUCT = gunicorn

$(eval $(python-package))
