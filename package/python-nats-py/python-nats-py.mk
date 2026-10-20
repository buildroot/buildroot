################################################################################
#
# python-nats-py
#
################################################################################

PYTHON_NATS_PY_VERSION = 2.16.0
PYTHON_NATS_PY_SOURCE = nats_py-$(PYTHON_NATS_PY_VERSION).tar.gz
PYTHON_NATS_PY_SITE = https://files.pythonhosted.org/packages/2c/c8/739b72c9201081e48000884d476231873ac82f7247c43b33823eaf3c0bfb
PYTHON_NATS_PY_SETUP_TYPE = pep517
PYTHON_NATS_PY_LICENSE = Apache-2.0
PYTHON_NATS_PY_LICENSE_FILES = LICENSE
PYTHON_NATS_PY_BUILD_OPTS = --skip-dependency-check
PYTHON_NATS_PY_DEPENDENCIES = host-python-uv-build

$(eval $(python-package))
