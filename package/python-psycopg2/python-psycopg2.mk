################################################################################
#
# python-psycopg2
#
################################################################################

PYTHON_PSYCOPG2_VERSION = 2.9.10
PYTHON_PSYCOPG2_SOURCE = psycopg2-$(PYTHON_PSYCOPG2_VERSION).tar.gz
PYTHON_PSYCOPG2_SITE = https://files.pythonhosted.org/packages/62/51/2007ea29e605957a17ac6357115d0c1a1b60c8c984951c19419b3474cdfd
PYTHON_PSYCOPG2_SETUP_TYPE = setuptools
PYTHON_PSYCOPG2_LICENSE = LGPL-3.0+
PYTHON_PSYCOPG2_LICENSE_FILES = LICENSE
PYTHON_PSYCOPG2_DEPENDENCIES = postgresql

# Force psycopg2 to use the Buildroot provided postgresql version
# instead of the one from the host machine
define PYTHON_PSYCOPG2_CREATE_SETUP_CFG
	printf "[build_ext]\ndefine=\npg_config=$(STAGING_DIR)/usr/bin/pg_config\n" > $(@D)/setup.cfg
endef
PYTHON_PSYCOPG2_PRE_CONFIGURE_HOOKS += PYTHON_PSYCOPG2_CREATE_SETUP_CFG

$(eval $(python-package))
