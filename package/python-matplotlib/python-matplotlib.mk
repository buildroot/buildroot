################################################################################
#
# python-matplotlib
#
################################################################################

PYTHON_MATPLOTLIB_VERSION = 3.10.0
PYTHON_MATPLOTLIB_SOURCE = matplotlib-$(PYTHON_MATPLOTLIB_VERSION).tar.gz
PYTHON_MATPLOTLIB_SITE = https://files.pythonhosted.org/packages/68/dd/fa2e1a45fce2d09f4aea3cee169760e672c8262325aa5796c49d543dc7e6
PYTHON_MATPLOTLIB_LICENSE = Python-2.0
PYTHON_MATPLOTLIB_LICENSE_FILES = LICENSE/LICENSE
PYTHON_MATPLOTLIB_DEPENDENCIES = \
	freetype \
	host-pkgconf \
	host-python-certifi \
	host-python-numpy \
	host-python-setuptools-scm \
	libpng \
	python-cycler \
	python-pybind \
	qhull
PYTHON_MATPLOTLIB_CONF_OPTS = \
	-Dmacosx=false \
	-Dsystem-freetype=true \
	-Dsystem-qhull=true
PYTHON_MATPLOTLIB_CONF_ENV += \
	_PYTHON_SYSCONFIGDATA_NAME=$(PKG_PYTHON_SYSCONFIGDATA_NAME) \
	PYTHONPATH=$(PYTHON3_PATH)

ifeq ($(BR2_PACKAGE_PYTHON_MATPLOTLIB_QT),y)
PYTHON_MATPLOTLIB_DEPENDENCIES += python-pyqt5
endif

$(eval $(meson-package))
