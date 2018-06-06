################################################################################
#
# vss-sdk
#
################################################################################

#$(eval $(virtual-package))

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
    mkdir -p $(TOPDIR)/output/build/${${1}_NAME}-${${1}_VERSION}/
    $(foreach flag,$(BUILDROOT_FLAGS), touch $(TOPDIR)/output/build/${${1}_NAME}-${${1}_VERSION}/$(flag);)
endef

define VSS_SDK_BUILD_CMDS
    $(call VSS_EXCLUDE_PACKAGE,OPENSSL)
    $(call VSS_EXCLUDE_PACKAGE,ZLIB)
    $(call VSS_EXCLUDE_PACKAGE,LIBPNG)
    $(call VSS_EXCLUDE_PACKAGE,LIBJPEG)
    $(call VSS_EXCLUDE_PACKAGE,JPEG_TURBO)
    $(call VSS_EXCLUDE_PACKAGE,EXPAT)
    $(call VSS_EXCLUDE_PACKAGE,LIBXML2)
    $(call VSS_EXCLUDE_PACKAGE,LIBXSLT)
    $(call VSS_EXCLUDE_PACKAGE,C_ARES)
    $(call VSS_EXCLUDE_PACKAGE,LIBCURL)
    $(call VSS_EXCLUDE_PACKAGE,LIBXKBCOMMON)
    $(call VSS_EXCLUDE_PACKAGE,LIBSOUP)
    $(call VSS_EXCLUDE_PACKAGE,LIBGLIB2)
    $(call VSS_EXCLUDE_PACKAGE,LIBFFI)
    $(call VSS_EXCLUDE_PACKAGE,ICU)
    $(call VSS_EXCLUDE_PACKAGE,ICUDATA)
    $(call VSS_EXCLUDE_PACKAGE,ORC)
    $(call VSS_EXCLUDE_PACKAGE,PCRE)
    $(call VSS_EXCLUDE_PACKAGE,SQLITE)
    $(call VSS_EXCLUDE_PACKAGE,FREETYPE)
    $(call VSS_EXCLUDE_PACKAGE,FONTCONFIG)
    $(call VSS_EXCLUDE_PACKAGE,KMOD)
    $(call VSS_EXCLUDE_PACKAGE,SHARED_MIME_INFO)
endef

define VSS_SDK_WRONG_PKG
    #$(call VSS_EXCLUDE_PACKAGE,GSTREAMER1) #Shipped v1.4.5 to old, v1.5.3 is required to enable ENCRYPTED_MEDIA.
    #$(call VSS_EXCLUDE_PACKAGE,GST1_PLUGINS_BASE)
    #$(call VSS_EXCLUDE_PACKAGE,GST1_PLUGINS_GOOD)
    #$(call VSS_EXCLUDE_PACKAGE,GST1_PLUGINS_BAD)
    #$(call VSS_EXCLUDE_PACKAGE,GST1_PLUGINS_UGLY)
    #$(call VSS_EXCLUDE_PACKAGE,MPG123) #libmpg123 v1.14.4, required >= 1.19.0 for BCM gst1 plugins
    #$(call VSS_EXCLUDE_PACKAGE,LIBGCRYPT) #v1.6.5 WPE needed v1.7.0 to enable Web Crypto API support.
    #$(call VSS_EXCLUDE_PACKAGE,LIBGPG_ERROR) #not detected properly libgpg-error 1.26
endef


define VSS_SDK_INSTALL_STAGING_CMDS
endef

define VSS_SDK_INSTALL_TARGET_CMDS
endef

$(eval $(generic-package))
