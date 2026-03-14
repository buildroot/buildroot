################################################################################
#
# python-aiomqtt
#
################################################################################

PYTHON_AIOMQTT_VERSION = 2.5.1
PYTHON_AIOMQTT_SOURCE = aiomqtt-$(PYTHON_AIOMQTT_VERSION).tar.gz
PYTHON_AIOMQTT_SITE = https://files.pythonhosted.org/packages/70/44/cfc58272783a11729462dc6df5adbfeabd084f840f609054ac772ae98c19
PYTHON_AIOMQTT_SETUP_TYPE = hatch
PYTHON_AIOMQTT_LICENSE = BSD-3-Clause
PYTHON_AIOMQTT_LICENSE_FILES = LICENSE

$(eval $(python-package))
