################################################################################
#
# wpeframework-spark
#
################################################################################

WPEFRAMEWORK_SPARK_VERSION = e722e104bb440bd0e87167285bf8bdc2e8a52e60
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

