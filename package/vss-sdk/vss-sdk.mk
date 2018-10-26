################################################################################
#
# vss-sdk
#
################################################################################

VSS_SDK_VERSION = c1484feb9cedf7ffcd4aeb89b69a20e24596d8d1
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
    $(call VSS_EXCLUDE_PACKAGE,FREETYPE)
    $(call VSS_EXCLUDE_PACKAGE,FONTCONFIG)
    $(call VSS_EXCLUDE_PACKAGE,ICU)
    $(call VSS_EXCLUDE_PACKAGE,ICUDATA)
    $(call VSS_EXCLUDE_PACKAGE,LIBJPEG)
    $(call VSS_EXCLUDE_PACKAGE,JPEG_TURBO)
    $(call VSS_EXCLUDE_PACKAGE,OPENSSL)
    $(call VSS_EXCLUDE_PACKAGE,ZLIB)
    $(call VSS_EXCLUDE_PACKAGE,LIBPNG)
    $(call VSS_EXCLUDE_PACKAGE,LIBCURL)
    $(call VSS_EXCLUDE_PACKAGE,PANGO)
    $(call VSS_EXCLUDE_PACKAGE,WEBP)
    $(call VSS_EXCLUDE_PACKAGE,MPG123)
    $(call VSS_EXCLUDE_PACKAGE,LIBMNG)
    $(call VSS_EXCLUDE_PACKAGE,OPUS)
    $(call VSS_EXCLUDE_PACKAGE,PIXMAN)
    $(call VSS_EXCLUDE_PACKAGE,BITSTREAM_VERA)
endef

define VSS_EXCLUDE_UNKNOWN_LIST
    $(call VSS_EXCLUDE_PACKAGE,EXPAT)
    $(call VSS_EXCLUDE_PACKAGE,LIBFFI)
    $(call VSS_EXCLUDE_PACKAGE,C_ARES)
    $(call VSS_EXCLUDE_PACKAGE,LIBXKBCOMMON)
    $(call VSS_EXCLUDE_PACKAGE,LIBSOUP)
    $(call VSS_EXCLUDE_PACKAGE,LIBGLIB2)
    $(call VSS_EXCLUDE_PACKAGE,ORC)
    $(call VSS_EXCLUDE_PACKAGE,SQLITE)
    $(call VSS_EXCLUDE_PACKAGE,KMOD)
    $(call VSS_EXCLUDE_PACKAGE,SHARED_MIME_INFO)
    # cairo-gl.h missing --> ACCELERATED_2D_CANVAS=OFF
    $(call VSS_EXCLUDE_PACKAGE,CAIRO)
    $(call VSS_EXCLUDE_PACKAGE,DASH)
    $(call VSS_EXCLUDE_PACKAGE,UTIL_LINUX)
    $(call VSS_EXCLUDE_PACKAGE,XUTIL_UTIL_MACROS)
    $(call VSS_EXCLUDE_PACKAGE,EUDEV)
    $(call VSS_EXCLUDE_PACKAGE,GST1_BCM)
endef

define VSS_SDK_WRONG_PKG
    # libgraphite2.so missing
    $(call VSS_EXCLUDE_PACKAGE,GRAPHITE2)
    # libharfbuzz-icu.so missing
    $(call VSS_EXCLUDE_PACKAGE,HARFBUZZ)
    # MSE needs this https://bugzilla.gnome.org/show_bug.cgi?id=768852  https://github.com/GStreamer/gst-plugins-base/commit/c6722c06a040a333188793d7f4403dd983c04815
    $(call VSS_EXCLUDE_PACKAGE,GSTREAMER1)
    $(call VSS_EXCLUDE_PACKAGE,GST1_PLUGINS_BASE)
    $(call VSS_EXCLUDE_PACKAGE,GST1_PLUGINS_GOOD)
    $(call VSS_EXCLUDE_PACKAGE,GST1_PLUGINS_BAD)
    $(call VSS_EXCLUDE_PACKAGE,GST1_PLUGINS_UGLY)
    $(call VSS_EXCLUDE_PACKAGE,FAAD2)
    # missing libgiognutls.so
    $(call VSS_EXCLUDE_PACKAGE,NETTLE)
    $(call VSS_EXCLUDE_PACKAGE,GMP)
    $(call VSS_EXCLUDE_PACKAGE,GNUTLS)
    $(call VSS_EXCLUDE_PACKAGE,GLIB_NETWORKING)
    # missing on box only
    # - /usr/lib/libxslt.so
    # - /usr/lib/libgcrypt.so
    # v1.6.5 => ENABLE_WEB_CRYPTO=OFF preferable +v1.7.0
    $(call VSS_EXCLUDE_PACKAGE,LIBGCRYPT)
    $(call VSS_EXCLUDE_PACKAGE,LIBGPG_ERROR)
    $(call VSS_EXCLUDE_PACKAGE,LIBXML2)
    $(call VSS_EXCLUDE_PACKAGE,LIBXSLT)
    $(call VSS_EXCLUDE_PACKAGE,LIBTASN1)
    $(call VSS_EXCLUDE_PACKAGE,LIBUNISTRING)
    $(call VSS_EXCLUDE_PACKAGE,PCRE)
endef

define VSS_SDK_BUILD_CMDS
 $(call VSS_WRITE_FLAGS)
 $(call VSS_EXCLUDE_PACKAGE_LIST)
endef

define VSS_SDK_INSTALL_STAGING_CMDS
    cp -av ${@D}/usr ${STAGING_DIR}
    cp -av ${@D}/etc ${STAGING_DIR}
endef

define VSS_SDK_INSTALL_TARGET_CMDS
    cp -av ${@D}/usr/lib/lib*.so* ${STAGING_DIR}/usr/lib
    cp -av ${@D}/etc ${TARGET_DIR}
endef

$(eval $(generic-package))
