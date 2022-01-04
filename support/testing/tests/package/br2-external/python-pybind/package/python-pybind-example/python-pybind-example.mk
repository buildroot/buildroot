################################################################################
#
# python-pybind-example
#
################################################################################

# this builds a C++ macro "add(a,b)"
# that we expose to host-python with a custom install
# and that the python test script will later use
PYTHON_PYBIND_EXAMPLE_DEPENDENCIES = python-pybind

PYTHON_PYBIND_EXAMPLE_PYBIND_INCLUDE = \
	$(shell $(HOST_DIR)/usr/bin/python3 -c 'import pybind11; print(pybind11.get_include())')

PYTHON_PYBIND_EXAMPLE_CXX_FLAGS = \
	$(TARGET_CXXFLAGS) \
	-Wall -shared -std=c++11 -fPIC \
	-I$(PYTHON_PYBIND_EXAMPLE_PYBIND_INCLUDE) \
	$(shell $(STAGING_DIR)/usr/bin/python3-config --includes --libs --ldflags)

# .so to be installed must have exact suffix
# otherwise import() in python will not work
HOST_LIB_BINARY_SUFFIX = \
	$(shell $(STAGING_DIR)/usr/bin/python3-config --extension-suffix)

define PYTHON_PYBIND_EXAMPLE_BUILD_CMDS
	if [ -z "$(PYTHON_PYBIND_EXAMPLE_PYBIND_INCLUDE)" ]; then \
		echo "pybind11.get_include() returned empty"; \
		exit 1; \
	fi
	$(TARGET_CXX) $(PYTHON_PYBIND_EXAMPLE_CXX_FLAGS) \
		$(PYTHON_PYBIND_EXAMPLE_PKGDIR)/example.cpp \
		-o $(@D)/example$(HOST_LIB_BINARY_SUFFIX)
endef

define PYTHON_PYBIND_EXAMPLE_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 755 $(@D)/example$(HOST_LIB_BINARY_SUFFIX) \
		$(TARGET_DIR)/usr/lib/python$(PYTHON3_VERSION_MAJOR)/site-packages/example$(HOST_LIB_BINARY_SUFFIX)
endef

$(eval $(generic-package))
