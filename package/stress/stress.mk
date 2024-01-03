################################################################################
#
# stress
#
################################################################################

STRESS_VERSION = 1.0.7
STRESS_SOURCE = stress-$(STRESS_VERSION).tar.bz2
STRESS_SITE = https://github.com/resurrecting-open-source-projects/stress/releases/download/$(STRESS_VERSION)
STRESS_LICENSE = GPL-2.0+
STRESS_LICENSE_FILES = COPYING

# Stress is linked statically if the --enable-static is specified.
# However, this option is always specified in the global
# SHARED_STATIC_LIBS_OPTS to tell packages to build static libraries,
# if supported.
#
# If the BR2_STATIC_LIBS is not defined, we have to specify
# --disable-static explicitly to get stress linked dynamically.
#
# Also, disable documentation by undefining makeinfo
STRESS_CONF_OPTS = \
	$(if $(BR2_STATIC_LIBS),,--disable-static) \
	MAKEINFO=:

$(eval $(autotools-package))
