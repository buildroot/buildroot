################################################################################
#
# wpeframework-spark
#
################################################################################

WPEFRAMEWORK_SPARK_VERSION = f7de254bd4fc61cb4f914e4715f0e740ef0dd728
WPEFRAMEWORK_SPARK_SITE_METHOD = git
WPEFRAMEWORK_SPARK_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginSpark.git
WPEFRAMEWORK_SPARK_INSTALL_STAGING = YES
WPEFRAMEWORK_SPARK_DEPENDENCIES = wpeframework spark

WPEFRAMEWORK_SPARK_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_SPARK_VERSION}

ifeq ($(BR2_PACKAGE_PLUGIN_SPARK_SPARK_AUTOSTART),y)
WPEFRAMEWORK_SPARK_CONF_OPTS += -DPLUGIN_SPARK_AUTOSTART=true
else
WPEFRAMEWORK_SPARK_CONF_OPTS += -DPLUGIN_SPARK_AUTOSTART=false
endif

$(eval $(cmake-package))

