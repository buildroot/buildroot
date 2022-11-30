################################################################################
#
# chartjs
#
################################################################################

CHARTJS_VERSION = 3.9.1
CHARTJS_SITE = https://registry.npmjs.org/chart.js/-
CHARTJS_SOURCE = chart.js-$(CHARTJS_VERSION).tgz
CHARTJS_LICENSE = MIT
CHARTJS_LICENSE_FILES = LICENSE.md
CHARTJS_CPE_ID_VENDOR = chartjs
CHARTJS_CPE_ID_PRODUCT = chart.js

define CHARTJS_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0644 -D $(@D)/dist/chart.min.js \
		$(TARGET_DIR)/var/www/chartjs/js/Chart.js
endef

$(eval $(generic-package))
