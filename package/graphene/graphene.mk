################################################################################
#
# graphene
#
################################################################################

GRAPHENE_VERSION = 1.10.8
GRAPHENE_SITE = $(call github,ebassi,graphene,$(GRAPHENE_VERSION))
GRAPHENE_LICENSE = MIT
GRAPHENE_LICENSE_FILES = LICENSE.txt
GRAPHENE_INSTALL_STAGING = YES

GRAPHENE_CONF_OPTS = \
	-Dtests=false \
	-Dinstalled_tests=false \
	-Dgtk_doc=false

ifeq ($(BR2_PACKAGE_LIBGLIB2),y)
GRAPHENE_CONF_OPTS += -Dgobject_types=true
GRAPHENE_DEPENDENCIES += libglib2
else
GRAPHENE_CONF_OPTS += -Dgobject_types=false
endif

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
GRAPHENE_CONF_OPTS += -Dintrospection=enabled
GRAPHENE_DEPENDENCIES += gobject-introspection
else
GRAPHENE_CONF_OPTS += -Dintrospection=disabled
endif

ifeq ($(BR2_X86_CPU_HAS_SSE2),y)
GRAPHENE_CONF_OPTS += -Dsse2=true
else
GRAPHENE_CONF_OPTS += -Dsse2=false
endif

ifeq ($(BR2_ARM_CPU_HAS_NEON),y)
GRAPHENE_CONF_OPTS += -Darm_neon=true
else
GRAPHENE_CONF_OPTS += -Darm_neon=false
endif

$(eval $(meson-package))
