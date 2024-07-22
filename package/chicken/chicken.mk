################################################################################
#
# chicken
#
################################################################################

CHICKEN_VERSION = 5.3.0
CHICKEN_SITE = https://code.call-cc.org/releases/$(CHICKEN_VERSION)
CHICKEN_LICENSE = BSD-3-Clause
CHICKEN_LICENSE_FILES = LICENSE
CHICKEN_CPE_ID_VENDOR = call-cc
CHICKEN_INSTALL_STAGING = YES

# Chicken only uses the "arch" variable for some special-case compile
# arguments If it's empty, it tries to detect the arch host Filter out
# values that have an effect, or pass "unused" here
ifeq ($(NORMALIZED_ARCH),x86_64)
CHICKEN_ARCH = x86-64
else ifeq ($(NORMALIZED_ARCH),xtensa)
CHICKEN_ARCH = xtensa
else
CHICKEN_ARCH = unused
endif

CHICKEN_MAKE_OPTS = \
	ARCH="$(CHICKEN_ARCH)" \
	C_COMPILER="$(TARGET_CC)" \
	CXX_COMPILER="$(TARGET_CXX)" \
	PREFIX=/usr \
	PLATFORM=linux \
	LIBRARIAN="$(TARGET_AR)"

ifeq ($(BR2_STATIC_LIBS),y)
CHICKEN_MAKE_OPTS += STATICBUILD=1
endif

define CHICKEN_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) \
		$(CHICKEN_MAKE_OPTS) all
endef

# README states that parallel builds are not supported..
define CHICKEN_INSTALL_STAGING_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) -C $(@D) \
		$(CHICKEN_MAKE_OPTS) DESTDIR=$(STAGING_DIR) install
endef

define CHICKEN_INSTALL_TARGET_CMDS
	$(TARGET_MAKE_ENV) $(MAKE1) -C $(@D) \
		$(CHICKEN_MAKE_OPTS) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
