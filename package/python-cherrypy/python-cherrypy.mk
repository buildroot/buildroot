################################################################################
#
# python-cherrypy
#
################################################################################

PYTHON_CHERRYPY_VERSION = 18.10.0
PYTHON_CHERRYPY_SOURCE = cherrypy-$(PYTHON_CHERRYPY_VERSION).tar.gz
PYTHON_CHERRYPY_SITE = https://files.pythonhosted.org/packages/93/e8/2f7ef142d1962d08a8885c4c9942212abecad6a80ccdd1620fd1f5c993fd
PYTHON_CHERRYPY_LICENSE = BSD-3-Clause
PYTHON_CHERRYPY_LICENSE_FILES = LICENSE.md
PYTHON_CHERRYPY_SETUP_TYPE = setuptools
PYTHON_CHERRYPY_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
