################################################################################
#
# python-msgfy
#
################################################################################

PYTHON_MSGFY_VERSION = 0.2.0
PYTHON_MSGFY_SOURCE = msgfy-$(PYTHON_MSGFY_VERSION).tar.gz
PYTHON_MSGFY_SITE = https://files.pythonhosted.org/packages/c6/2a/663ef86625f34ee4165da1eb824442cfb1f676e892946d7fe39a8c775682
PYTHON_MSGFY_SETUP_TYPE = setuptools
PYTHON_MSGFY_LICENSE = MIT
PYTHON_MSGFY_LICENSE_FILES = LICENSE

$(eval $(python-package))
