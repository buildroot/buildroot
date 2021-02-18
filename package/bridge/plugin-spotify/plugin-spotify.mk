################################################################################
#
# Plugin Spotify
#
################################################################################
PLUGIN_SPOTIFY_VERSION = trunk
PLUGIN_SPOTIFY_SITE = git@git.integraal.info:Integraal/plugins
PLUGIN_SPOTIFY_SUBDIR = src/spotify
PLUGIN_SPOTIFY_SITE_METHOD = git
PLUGIN_SPOTIFY_INSTALL_STAGING = NO 
PLUGIN_SPOTIFY_DEPENDENCIES = bridge bridge-contracts
PLUGIN_SPOTIFY_CONF_OPTS = -DBUILD_REFERENCE=${PLUGIN_SPOTIFY_VERSION}

ifeq ($(BR2_PACKAGE_BRIDGE_DEBUG),y)
PLUGIN_SPOTIFY_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug
endif

$(eval $(cmake-package))
