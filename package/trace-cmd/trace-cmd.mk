################################################################################
#
# trace-cmd
#
################################################################################

TRACE_CMD_VERSION = 3.2
TRACE_CMD_SOURCE = trace-cmd-v$(TRACE_CMD_VERSION).tar.gz
TRACE_CMD_SITE = \
	https://git.kernel.org/pub/scm/utils/trace-cmd/trace-cmd.git/snapshot
TRACE_CMD_LICENSE = GPL-2.0, LGPL-2.1
TRACE_CMD_LICENSE_FILES = COPYING COPYING.LIB LICENSES/GPL-2.0 LICENSES/LGPL-2.1

TRACE_CMD_DEPENDENCIES = host-pkgconf libtraceevent libtracefs
TRACE_CMD_MAKE_OPTS = prefix=/usr etcdir=/etc

ifeq ($(BR2_PACKAGE_AUDIT),y)
TRACE_CMD_DEPENDENCIES += audit
endif

ifeq ($(BR2_PACKAGE_PYTHON3),y)
TRACE_CMD_DEPENDENCIES += python3 host-swig
TRACE_CMD_MAKE_OPTS += PYTHON_VERS=python3
else
TRACE_CMD_MAKE_OPTS += NO_PYTHON=1
endif

# trace-cmd already defines _LARGEFILE64_SOURCE when necessary,
# redefining it on the command line causes build problems.
TRACE_CMD_CFLAGS = $(filter-out -D_LARGEFILE64_SOURCE,$(TARGET_CFLAGS))

# Sparc64 needs -fPIC
ifeq ($(BR2_sparc64),y)
TRACE_CMD_CFLAGS += -fPIC
endif

TRACE_CMD_CFLAGS += $($(HOST_DIR)/bin/pkg-config --cflags libtracefs)

# trace-cmd use CPPFLAGS to add some extra flags.
# But like for CFLAGS, $(TARGET_CPPFLAGS) contains _LARGEFILE64_SOURCE
# that causes build problems.
TRACE_CMD_CPPFLAGS = $(filter-out -D_LARGEFILE64_SOURCE,$(TARGET_CPPFLAGS))

define TRACE_CMD_BUILD_CMDS
	$(TARGET_CONFIGURE_OPTS) \
	CFLAGS="$(TRACE_CMD_CFLAGS)" \
	CPPFLAGS="$(TRACE_CMD_CPPFLAGS)" \
	$(MAKE) $(TRACE_CMD_MAKE_OPTS) -C $(@D)
endef

define TRACE_CMD_INSTALL_TARGET_CMDS
	$(TARGET_CONFIGURE_OPTS) \
	CFLAGS="$(TRACE_CMD_CFLAGS)" \
	CPPFLAGS="$(TRACE_CMD_CPPFLAGS)" \
	DESTDIR=$(TARGET_DIR) \
	$(MAKE) $(TRACE_CMD_MAKE_OPTS) -C $(@D) install
endef

$(eval $(generic-package))
