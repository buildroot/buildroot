################################################################################
#
# lua-mqtt
#
################################################################################

LUA_MQTT_VERSION = 0.1.0-1
LUA_MQTT_LICENSE = MIT
LUA_MQTT_LICENSE_FILES = $(LUA_MQTT_SUBDIR)/COPYRIGHT

$(eval $(luarocks-package))
