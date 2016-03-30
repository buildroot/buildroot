################################################################################
#
# sphinxbase
#
################################################################################

SPHINXBASE_VERSION = 5prealpha
SPHINXBASE_SOURCE = sphinxbase-$(SPHINXBASE_VERSION).tar.gz
SPHINXBASE_SITE = https://sourceforge.net/projects/cmusphinx/files/sphinxbase/5prealpha
SPHINXBASE_LICENSE = BSD
SPHINXBASE_LICENSE_FILES = License.txt

ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
SPHINXBASE_DEPENDENCIES += alsa-lib
endif

SPHINXBASE_DEPENDENCIES += host-pkgconf

define SPHINXBASE_CONFIGURE_CMDS
        cd $(@D); \
        $(TARGET_CONFIGURE_ARGS) \
        $(TARGET_CONFIGURE_OPTS) \
        CFLAGS="$(TARGET_CFLAGS)" \
        ./configure \
        --target=$(GNU_TARGET_NAME) \
        --host=$(GNU_TARGET_NAME) \
        --build=$(GNU_HOST_NAME) \
        --prefix=/usr  --without-python
endef

$(eval $(autotools-package))

