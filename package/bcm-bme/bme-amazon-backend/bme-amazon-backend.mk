################################################################################
#
# bme-amazon-backend
#
################################################################################

BME_AMAZON_BACKEND_VERSION = bbc9bb7070a6ad75dd0125cd6916d37c6248c6fd
BME_AMAZON_BACKEND_SITE = git@github.com:Metrological/bcm-bme.git
BME_AMAZON_BACKEND_SITE_METHOD = git
BME_AMAZON_BACKEND_DEPENDENCIES = bcm-bme
BME_AMAZON_BACKEND_LICENSE = PROPRIETARY
BME_AMAZON_BACKEND_INSTALL_STAGING = YES


NEXUS_CFLAGS=$(shell cat ${STAGING_DIR}/usr/include/platform_app.inc | grep NEXUS_CFLAGS | cut -d' ' -f3- | awk -F "-std=c89" '{print $$1 $$2}')
NEXUS_LDFLAGS=$(shell cat ${STAGING_DIR}/usr/include/platform_app.inc | grep NEXUS_LDFLAGS | cut -d' ' -f3-)
NEXUS_CLIENT_LD_LIBRARIES=$(shell cat ${STAGING_DIR}/usr/include/platform_app.inc | grep NEXUS_CLIENT_LD_LIBRARIES | cut -d' ' -f4-)

BME_AMAZON_BACKEND_OPTIONS = \
	CXX="$(TARGET_CXX)" \
	LD="$(TARGET_LD)" \
	AR="$(TARGET_AR)" \
	AS="$(TARGET_AS)" \
	RANLIB="$(TARGET_RANLIB)" \
	RUBY_TOP="$(@D)/amazon-backend" \
	TARGET_ROOT="$(STAGING_DIR)/usr" \
	NEXUS_CFLAGS="${NEXUS_CFLAGS}" \
	BME_INCLUDES="$(STAGING_DIR)/usr/include $(STAGING_DIR)/usr/include/refsw $(@D)/player/include/ $(@D)/shared"
	
ifneq ($(findstring aarch64,$(ARCH)),)
  BME_AMAZON_BACKEND_OPTIONS += BASE_ARCH=aarch64
endif
ifneq ($(findstring arm,$(ARCH)),)
  BME_AMAZON_BACKEND_OPTIONS += BASE_ARCH=arm
endif
ifneq ($(findstring mipsel,$(ARCH)),)
  BME_AMAZON_BACKEND_OPTIONS += BASE_ARCH=mips
endif

define  BME_AMAZON_BACKEND_INSTALL  
	$(INSTALL) -m 750 -D  $(@D)/amazon-backend/build/broadcom-backend/*.so $(1)/usr/lib	
endef

define  BME_AMAZON_BACKEND_INSTALL_DEV
  $(call BME_AMAZON_BACKEND_INSTALL,$(STAGING_DIR))
  $(INSTALL) -m 644 $(@D)/amazon-backend/broadcom-backend/*.h $(STAGING_DIR)/usr/include
endef	

define BME_AMAZON_BACKEND_BUILD_CMDS
   ${TARGET_MAKE_ENV} ${BME_AMAZON_BACKEND_OPTIONS} ${MAKE} -C $(@D)/amazon-backend/broadcom-backend 
endef

define BME_AMAZON_BACKEND_INSTALL_STAGING_CMDS
  $(call BME_AMAZON_BACKEND_INSTALL_DEV)
endef

define BME_AMAZON_BACKEND_INSTALL_TARGET_CMDS
  $(call BME_AMAZON_BACKEND_INSTALL,$(TARGET_DIR))
endef

$(eval $(generic-package))
 
