################################################################################
#
# python-paho-mqtt
#
################################################################################

PYTHON_PAHO_MQTT_VERSION = 2.1.0
PYTHON_PAHO_MQTT_SITE = $(call github,eclipse,paho.mqtt.python,v$(PYTHON_PAHO_MQTT_VERSION))
PYTHON_PAHO_MQTT_LICENSE = EPL-2.0, EDLv1.0
PYTHON_PAHO_MQTT_LICENSE_FILES = LICENSE.txt epl-v20 edl-v10
PYTHON_PAHO_MQTT_SETUP_TYPE = hatch

$(eval $(python-package))
