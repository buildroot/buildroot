################################################################################
#
# qrtr
#
################################################################################

QRTR_VERSION = 1.2
QRTR_SITE = $(call github,linux-msm,qrtr,v$(QRTR_VERSION))
QRTR_LICENSE = BSD-3-Clause
QRTR_LICENSE_FILES = LICENSE
QRTR_INSTALL_STAGING = YES
QRTR_CONF_OPTS = -Dqrtr-ns=disabled -Dsystemd-service=disabled

$(eval $(meson-package))
