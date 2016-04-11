################################################################################
#
# gluelogic
#
################################################################################

GLUELOGIC_VERSION = b93096bc809bc4cbfcee2c2d8743647a60c82727
GLUELOGIC_SITE_METHOD = git
GLUELOGIC_SITE = git@github.com:Metrological/gluelogic.git
GLUELOGIC_INSTALL_STAGING = YES
GLUELOGIC_DEPENDENCIES = cppsdk

ifeq ($(BR2_ENABLE_DEBUG),y)
GLUELOGIC_CONF_OPTS += -DGLUELOGIC_DEBUG=ON
else ifeq ($(BR2_PACKAGE_CPPSDK_DEBUG),y)
GLUELOGIC_CONF_OPTS += -DGLUELOGIC_DEBUG=ON
endif

ifeq ($(BR2_PACKAGE_GLUELOGIC_QUEUEPLAYER),y)
GLUELOGIC_CONF_OPTS += -DGLUELOGIC_QUEUEPLAYER=ON
endif

ifeq ($(BR2_PACKAGE_GLUELOGIC_VIRTUAL_KEYBOARD),y)
GLUELOGIC_CONF_OPTS += -DGLUELOGIC_VIRTUAL_KEYBOARD=ON
endif

ifeq ($(BR2_PACKAGE_GLUELOGIC_KEYBOARDSCANNER),y)
GLUELOGIC_CONF_OPTS += -DGLUELOGIC_KEYBOARDSCANNER=ON
endif

$(eval $(cmake-package))
