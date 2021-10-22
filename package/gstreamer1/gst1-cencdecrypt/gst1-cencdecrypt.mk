GST1_CENCDECRYPT_VERSION = dad6b3e32783f8c127eddf824813d8e9725f579f
GST1_CENCDECRYPT_SITE = git@github.com:WebPlatformForEmbedded/gstcencdecryptor.git
GST1_CENCDECRYPT_SITE_METHOD = git
GST1_CENCDECRYPT_INSTALL_STAGING = YES
GST1_CENCDECRYPT_DEPENDENCIES = gstreamer1 wpeframework wpeframework-clientlibraries wpeframework-plugins curl

$(eval $(cmake-package))
