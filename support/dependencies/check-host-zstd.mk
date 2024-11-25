ifeq (,$(call suitable-host-package,zstd,$(ZSTDCAT)))
BR2_ZSTD_HOST_DEPENDENCY = host-zstd
ZSTDCAT = $(HOST_DIR)/bin/zstdcat
endif
