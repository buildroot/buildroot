################################################################################
#
# vss-sdk
#
################################################################################

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

$(eval $(virtual-package))
