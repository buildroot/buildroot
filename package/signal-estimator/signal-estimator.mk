################################################################################
#
# signal-estimator
#
################################################################################

SIGNAL_ESTIMATOR_VERSION = v0.0.4
SIGNAL_ESTIMATOR_SITE = https://github.com/gavv/signal-estimator
SIGNAL_ESTIMATOR_SITE_METHOD = git
SIGNAL_ESTIMATOR_GIT_SUBMODULES = YES

SIGNAL_ESTIMATOR_LICENSE = MIT
SIGNAL_ESTIMATOR_LICENSE_FILES = LICENSE

SIGNAL_ESTIMATOR_DEPENDENCIES = alsa-lib

SIGNAL_ESTIMATOR_CONF_OPTS += -DBUILD_GUI=OFF

$(eval $(cmake-package))
