################################################################################
#
# wpeframework-spark
#
################################################################################

WPEFRAMEWORK_SPARK_VERSION = 140a3d29560b63921eff31bb92e86fac1ddb1d9c
WPEFRAMEWORK_SPARK_SITE_METHOD = git
WPEFRAMEWORK_SPARK_SITE = git@github.com:WebPlatformForEmbedded/WPEPluginSpark.git
WPEFRAMEWORK_SPARK_INSTALL_STAGING = YES
WPEFRAMEWORK_SPARK_DEPENDENCIES = wpeframework spark freetype

WPEFRAMEWORK_SPARK_CONF_OPTS += -DBUILD_REFERENCE=${WPEFRAMEWORK_SPARK_VERSION}

ifeq ($(BR2_PACKAGE_PLUGIN_SPARK_SPARK_AUTOSTART),y)
WPEFRAMEWORK_SPARK_CONF_OPTS += -DPLUGIN_SPARK_AUTOSTART=true
else
WPEFRAMEWORK_SPARK_CONF_OPTS += -DPLUGIN_SPARK_AUTOSTART=false
endif

ifeq ($(BR2_PACKAGE_RPI_USERLAND),y)
WPEFRAMEWORK_SPARK_CONF_OPTS += -DPLATFORM_LINUX=ON
endif

$(eval $(cmake-package))

