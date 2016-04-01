################################################################################
#
# pocketsphinx
#
################################################################################

POCKETSPHINX_VERSION = 5prealpha
POCKETSPHINX_SOURCE = pocketsphinx-$(POCKETSPHINX_VERSION).tar.gz
POCKETSPHINX_SITE = https://sourceforge.net/projects/cmusphinx/files/pocketsphinx/5prealpha
POCKETSPHINX_LICENSE = BSD
POCKETSPHINX_LICENSE_FILES = License.txt
POCKETSPHINX_DEPENDENCIES = host-pkgconf


define POCKETSPHINX_CONFIGURE_CMDS
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

POCKETSPHINX_DEPENDENCIES += sphinxbase

$(eval $(autotools-package))
