################################################################################
#
# python-aiomqtt
#
################################################################################

PYTHON_AIOMQTT_VERSION = 2.4.0
PYTHON_AIOMQTT_SOURCE = aiomqtt-$(PYTHON_AIOMQTT_VERSION).tar.gz
PYTHON_AIOMQTT_SITE = https://files.pythonhosted.org/packages/45/9a/863bc34c64bc4acb9720a9950bfc77d6f324640cdf1f420bb5d9ee624975
PYTHON_AIOMQTT_SETUP_TYPE = hatch
PYTHON_AIOMQTT_LICENSE = BSD-3-Clause
PYTHON_AIOMQTT_LICENSE_FILES = LICENSE

$(eval $(python-package))
