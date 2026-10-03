################################################################################
#
# python-socketio
#
################################################################################

PYTHON_SOCKETIO_VERSION = 5.17.0
PYTHON_SOCKETIO_SOURCE = python_socketio-$(PYTHON_SOCKETIO_VERSION).tar.gz
PYTHON_SOCKETIO_SITE = https://files.pythonhosted.org/packages/b9/04/8647675c93b5e74a3daa41a2a03930bac0cbdcfcf307900f0441ae6550ba
PYTHON_SOCKETIO_SETUP_TYPE = setuptools
PYTHON_SOCKETIO_LICENSE = MIT
PYTHON_SOCKETIO_LICENSE_FILES = LICENSE

$(eval $(python-package))
