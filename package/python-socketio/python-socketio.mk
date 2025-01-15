################################################################################
#
# python-socketio
#
################################################################################

PYTHON_SOCKETIO_VERSION = 5.12.1
PYTHON_SOCKETIO_SOURCE = python_socketio-$(PYTHON_SOCKETIO_VERSION).tar.gz
PYTHON_SOCKETIO_SITE = https://files.pythonhosted.org/packages/ce/d0/40ed38076e8aee94785d546d3e3a1cae393da5806a8530be877187e2875f
PYTHON_SOCKETIO_SETUP_TYPE = setuptools
PYTHON_SOCKETIO_LICENSE = MIT
PYTHON_SOCKETIO_LICENSE_FILES = LICENSE

$(eval $(python-package))
