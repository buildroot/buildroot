################################################################################
#
# gluelogic
#
################################################################################

GLUELOGIC_VERSION = e2184d10733f423e564fb25ff9c429fc85e747f3
GLUELOGIC_SITE_METHOD = git
GLUELOGIC_SITE = git@github.com:Metrological/gluelogic.git
GLUELOGIC_INSTALL_STAGING = YES

ifeq ($(BR2_ENABLE_DEBUG),y)
GLUELOGIC_CONF_OPTS += -DGLUELOGIC_DEBUG=ON
else ifeq ($(BR2_PACKAGE_CPPSDK_DEBUG),y)
GLUELOGIC_CONF_OPTS += -DGLUELOGIC_DEBUG=ON
endif

ifeq ($(BR2_PACKAGE_GLUELOGIC_QUEUEPLAYER),y)
GLUELOGIC_CONF_OPTS += -DGLUELOGIC_QUEUEPLAYER=ON -DGLUELOGIC_QUEUEPLAYER_TESTS=ON
GLUELOGIC_DEPENDENCIES += cppsdk
endif

$(eval $(cmake-package))
