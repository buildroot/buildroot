################################################################################
#
# python-msgfy
#
################################################################################

PYTHON_MSGFY_VERSION = 0.2.1
PYTHON_MSGFY_SOURCE = msgfy-$(PYTHON_MSGFY_VERSION).tar.gz
PYTHON_MSGFY_SITE = https://files.pythonhosted.org/packages/51/0e/b78151a63e8c5cab745e90ed7b4a741dba5439a8538636bf6a5da72bad23
PYTHON_MSGFY_SETUP_TYPE = setuptools
PYTHON_MSGFY_LICENSE = MIT
PYTHON_MSGFY_LICENSE_FILES = LICENSE

$(eval $(python-package))
