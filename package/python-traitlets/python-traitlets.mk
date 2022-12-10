################################################################################
#
# python-traitlets
#
################################################################################

PYTHON_TRAITLETS_VERSION = 5.7.0
PYTHON_TRAITLETS_SOURCE = traitlets-$(PYTHON_TRAITLETS_VERSION).tar.gz
PYTHON_TRAITLETS_SITE = https://files.pythonhosted.org/packages/a2/88/5b2a191dd0287b45b933405d951ebfc490a9dfee2494442e5977653ec43b
PYTHON_TRAITLETS_LICENSE = BSD-3-Clause
PYTHON_TRAITLETS_LICENSE_FILES = COPYING.md
PYTHON_TRAITLETS_SETUP_TYPE = pep517
PYTHON_TRAITLETS_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
