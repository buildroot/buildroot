################################################################################
#
# python-aiodns
#
################################################################################

PYTHON_AIODNS_VERSION = 3.0.0
PYTHON_AIODNS_SOURCE = aiodns-$(PYTHON_AIODNS_VERSION).tar.gz
PYTHON_AIODNS_SITE = https://files.pythonhosted.org/packages/27/79/df72e25df0fdd9bf5a5ab068539731d27c5f2ae5654621ae0c92ceca94cf
PYTHON_AIODNS_SETUP_TYPE = setuptools
PYTHON_AIODNS_LICENSE = MIT
PYTHON_AIODNS_LICENSE_FILES = LICENSE

$(eval $(python-package))
