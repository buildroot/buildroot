################################################################################
#
# vss-sdk
#
################################################################################

VSS_SDK_VERSION = 0322667c195a932ece656fcbfd4324b5afd16c31
VSS_SDK_SITE = git@github.com:Metrological/SDK_VSS.git
VSS_SDK_SITE_METHOD = git
VSS_SDK_LICENSE = PROPRIETARY
VSS_SDK_INSTALL_STAGING = YES
VSS_SDK_INSTALL_TARGET = YES

BUILDROOT_FLAGS = .stamp_downloaded \
                  .stamp_extracted \
                  .applied_patches_list \
                  .stamp_patched \
                  .stamp_configured \
                  .stamp_built \
                  .stamp_staging_installed \
                  .br_filelist_before \
                  .br_filelist_after \
                  .stamp_target_installed \
                  .stamp_host_installed \
                  .stamp_images_installed

define VSS_EXCLUDE_PACKAGE
    $(info "Excluding ${${1}_NAME}-${${1}_VERSION} from build, provided by SDK")
    rm -rf $(BASE_DIR)/build/${${1}_NAME}-${${1}_VERSION}
    ln -sf $(@D)/br_flags $(BASE_DIR)/build/${${1}_NAME}-${${1}_VERSION}
endef

define VSS_WRITE_FLAGS
    mkdir -p $(@D)/br_flags/
    $(foreach flag,$(BUILDROOT_FLAGS), touch $(@D)/br_flags/$(flag);)
endef

define VSS_EXCLUDE_PACKAGE_LIST
    $(call VSS_EXCLUDE_PACKAGE,CAIRO)
    $(call VSS_EXCLUDE_PACKAGE,C_ARES)
    $(call VSS_EXCLUDE_PACKAGE,EXPAT)
    $(call VSS_EXCLUDE_PACKAGE,FAAD2)
    $(call VSS_EXCLUDE_PACKAGE,FREETYPE)
    $(call VSS_EXCLUDE_PACKAGE,FONTCONFIG)
    $(call VSS_EXCLUDE_PACKAGE,HARFBUZZ)
    $(call VSS_EXCLUDE_PACKAGE,GLIB_NETWORKING)
    $(call VSS_EXCLUDE_PACKAGE,LIBCURL)
    $(call VSS_EXCLUDE_PACKAGE,LIBEPOXY)
    $(call VSS_EXCLUDE_PACKAGE,LIBGLIB2)
    $(call VSS_EXCLUDE_PACKAGE,LIBGCRYPT)
    $(call VSS_EXCLUDE_PACKAGE,LIBGPG_ERROR)
    $(call VSS_EXCLUDE_PACKAGE,LIBJPEG)
    $(call VSS_EXCLUDE_PACKAGE,LIBMNG)
    $(call VSS_EXCLUDE_PACKAGE,LIBPNG)
    $(call VSS_EXCLUDE_PACKAGE,LIBXKBCOMMON)
    $(call VSS_EXCLUDE_PACKAGE,MPG123)
    $(call VSS_EXCLUDE_PACKAGE,OPENSSL)
    $(call VSS_EXCLUDE_PACKAGE,JPEG_TURBO)
    $(call VSS_EXCLUDE_PACKAGE,WEBP)
    $(call VSS_EXCLUDE_PACKAGE,ZLIB)
    $(call VSS_EXCLUDE_PACKAGE,LIBXML2)
    $(call VSS_EXCLUDE_PACKAGE,LIBXSLT)
    $(call VSS_EXCLUDE_PACKAGE,NETTLE)
    $(call VSS_EXCLUDE_PACKAGE,LIBPNG)
    $(call VSS_EXCLUDE_PACKAGE,LIBSOUP)
    $(call VSS_EXCLUDE_PACKAGE,PCRE)
    $(call VSS_EXCLUDE_PACKAGE,LIBFFI)
    $(call VSS_EXCLUDE_PACKAGE,ORC)
    $(call VSS_EXCLUDE_PACKAGE,PIXMAN)
    $(call VSS_EXCLUDE_PACKAGE,SHARED_MIME_INFO)
    $(call VSS_EXCLUDE_PACKAGE,BITSTREAM_VERA)
    $(call VSS_EXCLUDE_PACKAGE,UTIL_LINUX)
    $(call VSS_EXCLUDE_PACKAGE,NGHTTP2)
    $(call VSS_EXCLUDE_PACKAGE,SQLITE)
    $(call VSS_EXCLUDE_PACKAGE,KMOD)
    $(call VSS_EXCLUDE_PACKAGE,EUDEV)
    $(call VSS_EXCLUDE_PACKAGE,ICU)
    $(call VSS_EXCLUDE_PACKAGE,ICUDATA)
    $(call VSS_EXCLUDE_PACKAGE,TREMOR)
    $(call VSS_EXCLUDE_PACKAGE,GNUTLS)
    $(call VSS_EXCLUDE_PACKAGE,OPUS)
    $(call VSS_EXCLUDE_PACKAGE,PROTOBUF)
    $(call VSS_EXCLUDE_PACKAGE,LIBOGG)
    $(call VSS_EXCLUDE_PACKAGE,GMP)
    $(call VSS_EXCLUDE_PACKAGE,XUTIL_UTIL_MACROS)
endef

define VSS_SDK_BUILD_CMDS
    $(call VSS_WRITE_FLAGS)
    $(call VSS_EXCLUDE_PACKAGE_LIST)
endef

define VSS_SDK_INSTALL_STAGING_CMDS
    cp -a ${@D}/usr ${STAGING_DIR}
    cp -a ${@D}/etc ${STAGING_DIR}
    cp -a ${@D}/lib ${STAGING_DIR}
endef

define VSS_SDK_INSTALL_INITD
     mkdir -p $(TARGET_DIR)/etc/init.d

     sed -e 's;%SAGEPATH%;$(BR2_PACKAGE_NEXUS_SAGE_PATH);g' \
	 -e 's;%IRMODE%;16;g' \
	 -e 's;%BOXMODE%;1;g' \
	 -e 's;%GRAPHICS_HEAP_SIZE%;100000000;g' \
	 -e 's;%NXSERVERARGS%;$(BR2_PACKAGE_VSS_SDK_NXSERVER_ARGS);g' \
	 $(@D)/templates/nxserver.in > $(@D)/nxserver.env 

     $(INSTALL) -m 0755  $(@D)/nxserver.env $(TARGET_DIR)/etc
     $(INSTALL) -m 0755  $(@D)/init.d/* $(TARGET_DIR)/etc/init.d
endef

define VSS_SDK_INSTALL_TARGET_CMDS_DISABLED
    cp -a ${@D}/usr/lib/lib*.so* ${TARGET_DIR}/usr/lib
    cp -a ${@D}/usr/bin/* ${TARGET_DIR}/usr/bin
    cp -a ${@D}/usr/sbin/* ${TARGET_DIR}/usr/sbin
    cp -a ${@D}/etc ${TARGET_DIR}
    cp -a ${@D}/lib ${TARGET_DIR}

    mkdir -p  $(TARGET_DIR)$(BR2_PACKAGE_NEXUS_SAGE_PATH)
    $(INSTALL) -D -m 0644 $(@D)/sage/* $(TARGET_DIR)/$(BR2_PACKAGE_NEXUS_SAGE_PATH)/
endef

define VSS_SDK_INSTALL_TARGET_CMDS
endef


ifeq ($(BR2_PACKAGE_VSS_SDK_INSTALL_INITD),y)
	VSS_SDK_POST_INSTALL_TARGET_HOOKS += VSS_SDK_INSTALL_INITD
endif

$(eval $(generic-package))
