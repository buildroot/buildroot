# Generates glibc locale data for target.

inputfile = $(firstword $(subst ., ,$(1)))
charmap = $(or $(word 2,$(subst ., ,$(1))),UTF-8)

# Packages all the generated locale data into the final archive.
#
# We sort the file names to produce consistent output regardless of
# the `find` outputs order.
$(TARGET_DIR)/usr/lib/locale/locale-archive: $(LOCALES)
	$(Q)rm -f $(@)
	$(Q)find $(TARGET_DIR)/usr/lib/locale/ -maxdepth 1 -mindepth 1 -type d -print0 \
	| sort -z \
	| xargs -0 \
		$(HOST_DIR)/bin/localedef \
			--prefix=$(TARGET_DIR) \
			--$(ENDIAN)-endian \
			--add-to-archive

# Generates locale data for each locale.
#
# The input data comes preferably from the toolchain, or if the toolchain
# does not have them (Linaro toolchains), we use the ones available on the
# host machine.
#
# Uses `localedef`, which is built by the `host-localedef` package.
$(LOCALES): | $(TARGET_DIR)/usr/lib/locale/
	$(Q)echo "Generating locale $(@)"
	$(Q)I18NPATH=$(STAGING_DIR)/usr/share/i18n:/usr/share/i18n \
	$(HOST_DIR)/bin/localedef \
		--prefix=$(TARGET_DIR) \
		--$(ENDIAN)-endian \
		--no-archive \
		-i $(call inputfile,$(@)) \
		-f $(call charmap,$(@)) \
		$(@)

.PHONY: $(LOCALES)

$(TARGET_DIR)/usr/lib/locale/:
	$(Q)mkdir -p $(TARGET_DIR)/usr/lib/locale/
