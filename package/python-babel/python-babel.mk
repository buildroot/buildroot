################################################################################
#
# python-babel
#
################################################################################

PYTHON_BABEL_VERSION = 2.13.1
PYTHON_BABEL_SOURCE = Babel-$(PYTHON_BABEL_VERSION).tar.gz
PYTHON_BABEL_SITE = https://files.pythonhosted.org/packages/aa/6c/737d2345d86741eeb594381394016b9c74c1253b4cbe274bb1e7b5e2138e
PYTHON_BABEL_SETUP_TYPE = setuptools
PYTHON_BABEL_LICENSE = BSD-3-Clause
PYTHON_BABEL_LICENSE_FILES = LICENSE
HOST_PYTHON_BABEL_DEPENDENCIES = host-python-pytz

# purge locale data (if enabled), keep special en_US_POSIX data which
# is used by default by the python-babel code
ifeq ($(BR2_ENABLE_LOCALE_PURGE),y)
define PYTHON_BABEL_CLEANUP_LOCALE
	for i in `ls $(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages/babel/locale-data/*.dat`; \
	do \
		i_base=`basename "$$i" .dat`; \
		echo "$(BR2_ENABLE_LOCALE_WHITELIST) en_US_POSIX" | grep -qw "$$i_base" || rm "$$i"; \
	done
endef
PYTHON_BABEL_TARGET_FINALIZE_HOOKS += PYTHON_BABEL_CLEANUP_LOCALE
endif

$(eval $(python-package))
$(eval $(host-python-package))
