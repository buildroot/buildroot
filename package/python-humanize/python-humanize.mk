################################################################################
#
# python-humanize
#
################################################################################

PYTHON_HUMANIZE_VERSION = 4.16.0
PYTHON_HUMANIZE_SOURCE = humanize-$(PYTHON_HUMANIZE_VERSION).tar.gz
PYTHON_HUMANIZE_SITE = https://files.pythonhosted.org/packages/0a/ea/13a1ef3c12d12662905801495283530251918b70d62d368f1d2e0272c70d
PYTHON_HUMANIZE_SETUP_TYPE = hatch
PYTHON_HUMANIZE_LICENSE = MIT
PYTHON_HUMANIZE_LICENSE_FILES = LICENCE
PYTHON_HUMANIZE_DEPENDENCIES = host-python-hatch-vcs

$(eval $(python-package))
