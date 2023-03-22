################################################################################
#
# python-babel
#
################################################################################

PYTHON_BABEL_VERSION = 2.12.1
PYTHON_BABEL_SOURCE = Babel-$(PYTHON_BABEL_VERSION).tar.gz
PYTHON_BABEL_SITE = https://files.pythonhosted.org/packages/ba/42/54426ba5d7aeebde9f4aaba9884596eb2fe02b413ad77d62ef0b0422e205
PYTHON_BABEL_SETUP_TYPE = setuptools
PYTHON_BABEL_LICENSE = BSD-3-Clause
PYTHON_BABEL_LICENSE_FILES = LICENSE
HOST_PYTHON_BABEL_DEPENDENCIES = host-python-pytz

$(eval $(python-package))
$(eval $(host-python-package))
