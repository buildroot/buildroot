# directory name that will hold temporary package generation files
SIMPLE_OPKG_TOOLS_TEMP_FILENAME=package.tmp
# directory where generated packages will be installed
SIMPLE_OPKG_TOOLS_PKG_OUTPUT_DIR=${BASE_DIR}/ipkg
# packages that needs to be built before
SIMPLE_OPKG_TOOLS_DEPENDENCIES=host-opkg-utils

define inner-sot-ensure-var-set
	@# Checks whether given variable is set and strips it from quotes
	$(if ${${1}},\
	@echo "${1}=${${1}}",\
	$(error "${1} not defined!")\
	)

	$(eval ${1} := $(call qstrip,${${1}}))
endef # inner-sot-ensure-var-set

define SIMPLE_OPKG_TOOLS_INIT
	@# Creates necessary files and directories to build package
	@# Input arguments:
	@# 	1 - package name
	@#	2 - workdir/destination

	@# ensure that all REQUIRED fields are present
	$(call inner-sot-ensure-var-set,${1}_OPKG_NAME)
	$(call inner-sot-ensure-var-set,${1}_OPKG_VERSION)
	$(call inner-sot-ensure-var-set,${1}_OPKG_DEPENDS)
	$(call inner-sot-ensure-var-set,${1}_OPKG_ARCHITECTURE)
	$(call inner-sot-ensure-var-set,${1}_OPKG_MAINTAINER)
	$(call inner-sot-ensure-var-set,${1}_OPKG_SOURCE)
	$(call inner-sot-ensure-var-set,${1}_OPKG_SECTION)
	$(call inner-sot-ensure-var-set,${1}_OPKG_PRIORITY)
	$(call inner-sot-ensure-var-set,${1}_OPKG_DESCRIPTION)

	@# prepare necessary files
	${INSTALL} -d ${2}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME}
	$(RM) -r ${2}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME}/*
	${INSTALL} -d ${2}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME}/CONTROL

	@# create fields in control file
	@echo "Package: ${${1}_OPKG_NAME}" >> ${2}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME}/CONTROL/control
	@echo "Version: ${${1}_OPKG_VERSION}" >> ${2}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME}/CONTROL/control
	@echo "Depends: ${${1}_OPKG_DEPENDS}" >> ${2}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME}/CONTROL/control
	@echo "Architecture: ${${1}_OPKG_ARCHITECTURE}" >> ${2}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME}/CONTROL/control
	@echo "Maintainer: ${${1}_OPKG_MAINTAINER}" >> ${2}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME}/CONTROL/control
	@echo "Section: ${${1}_OPKG_SECTION}" >> ${2}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME}/CONTROL/control
	@echo "Source: ${${1}_OPKG_SOURCE}" >> ${2}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME}/CONTROL/control
	@echo "Priority: ${${1}_OPKG_PRIORITY}" >> ${2}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME}/CONTROL/control
	@echo "Description: ${${1}_OPKG_DESCRIPTION}" >> ${2}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME}/CONTROL/control
endef # SIMPLE_OPKG_TOOLS_INIT

define SIMPLE_OPKG_TOOLS_SET_CUSTOM_FIELD
	@# Adds custom field to package control file
	@# Input arguments:
	@#	1 - workdir/destination
	@#	2 - custom field key
	@#	3 - custom field value
	@echo "${2}: ${3}" >> ${1}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME}/CONTROL/control
endef # SIMPLE_OPKG_TOOLS_SET_CUSTOM_FIELD

define SIMPLE_OPKG_TOOLS_BUILD_PACKAGE
	@# Builds package from already prepared directory
	@# Input arguments:
	@#	1 - package target directory
	opkg-build ${1}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME} ${1}
endef # SIMPLE_OPKG_TOOLS_BUILD_PACKAGE

define SIMPLE_OPKG_TOOLS_SET_TARGET
	@# Sets new target path to package temporary directory
	@# Input arguments:
	@#	1 - package name
	@#	2 - new TARGET_DIR
	$(eval ${1}_ORIGINAL_TARGET := ${TARGET_DIR})
	$(eval TARGET_DIR := ${2}/${SIMPLE_OPKG_TOOLS_TEMP_FILENAME})
	@echo "New TARGET_DIR=${TARGET_DIR}"
endef # SIMPLE_OPKG_TOOLS_SET_TARGET

define SIMPLE_OPKG_TOOLS_UNSET_TARGET
	@# Reverts target path, set by SIMPLE_OPKG_TOOLS_SET_TARGET
	@# Input arguments:
	@#	1 - package name
	$(eval TARGET_DIR := ${${1}_ORIGINAL_TARGET})
	@echo "New TARGET_DIR=${TARGET_DIR}"
endef # SIMPLE_OPKG_TOOLS_UNSET_TARGET

define SIMPLE_OPKG_TOOLS_INSTALL_PACKAGE
	@# Installs built package in output path
	@# Input arguments:
	@#	1 - package path
	${INSTALL} -d  ${SIMPLE_OPKG_TOOLS_PKG_OUTPUT_DIR}
	${INSTALL} -m 755 ${1} ${SIMPLE_OPKG_TOOLS_PKG_OUTPUT_DIR}
endef # SIMPLE_OPKG_TOOLS_INSTALL_PACKAGE

define SIMPLE_OPKG_TOOLS_MAKE_PACKAGE
	@# Makes package from CPack generated makefile
	${MAKE} package -C ${@D}
endef # SIMPLE_OPKG_TOOLS_MAKE_PACKAGE

define SIMPLE_OPKG_TOOLS_CREATE_CPACK_METADATA
	@# Creates CMake build parameters for CPack configuration
	@# Input arguments:
	@# 	1 - package name
	$(call inner-sot-ensure-var-set,${1}_OPKG_NAME)
	$(call inner-sot-ensure-var-set,${1}_OPKG_VERSION)
	$(call inner-sot-ensure-var-set,${1}_OPKG_ARCHITECTURE)
	$(call inner-sot-ensure-var-set,${1}_OPKG_MAINTAINER)
	$(call inner-sot-ensure-var-set,${1}_OPKG_DESCRIPTION)

	$(eval ${1}_OPKG_CPACK_METADATA += -D${1}_OPKG_NAME="${${1}_OPKG_NAME}")
	$(eval ${1}_OPKG_CPACK_METADATA += -D${1}_OPKG_VERSION="${${1}_OPKG_VERSION}")
	$(eval ${1}_OPKG_CPACK_METADATA += -D${1}_OPKG_ARCHITECTURE="${${1}_OPKG_ARCHITECTURE}")
	$(eval ${1}_OPKG_CPACK_METADATA += -D${1}_OPKG_MAINTAINER="${${1}_OPKG_MAINTAINER}")
	$(eval ${1}_OPKG_CPACK_METADATA += -D${1}_OPKG_DESCRIPTION="${${1}_OPKG_DESCRIPTION}")
	$(eval ${1}_OPKG_CPACK_METADATA += -D${1}_OPKG_FILE_NAME="${${1}_OPKG_NAME}_${${1}_OPKG_VERSION}_${${1}_OPKG_ARCHITECTURE}")
endef # SIMPLE_OPKG_TOOLS_CREATE_CPACK_METADATA

define SIMPLE_OPKG_TOOLS_REMOVE_FROM_TARGET
	@# Remove files installed by CMake in TARGET_DIR, that already belongs to the packages
	@( \
	for manifest in ${@D}/install_manifest_*; \
	do \
		echo "Removing file(s) included in $${manifest}..."; \
		cat $${manifest} | xargs printf -- "$${TARGET_DIR}/%s\n"; \
		cat $${manifest} | xargs printf -- "$${TARGET_DIR}/%s\n" | xargs rm; \
	done \
	)
endef # SIMPLE_OPKG_TOOLS_REMOVE_FROM_TARGET