################################################################################
#
# python-gunicorn
#
################################################################################

PYTHON_GUNICORN_VERSION = 21.2.0
PYTHON_GUNICORN_SOURCE = gunicorn-$(PYTHON_GUNICORN_VERSION).tar.gz
PYTHON_GUNICORN_SITE = https://files.pythonhosted.org/packages/06/89/acd9879fa6a5309b4bf16a5a8855f1e58f26d38e0c18ede9b3a70996b021
PYTHON_GUNICORN_SETUP_TYPE = setuptools
PYTHON_GUNICORN_LICENSE = MIT
PYTHON_GUNICORN_LICENSE_FILES = LICENSE
PYTHON_GUNICORN_CPE_ID_VENDOR = gunicorn
PYTHON_GUNICORN_CPE_ID_PRODUCT = gunicorn

$(eval $(python-package))
