################################################################################
#
# python-memory-profiler
#
################################################################################

PYTHON_MEMORY_PROFILER_VERSION = 0.61.0
PYTHON_MEMORY_PROFILER_SOURCE = memory_profiler-$(PYTHON_MEMORY_PROFILER_VERSION).tar.gz
PYTHON_MEMORY_PROFILER_SITE = https://files.pythonhosted.org/packages/b2/88/e1907e1ca3488f2d9507ca8b0ae1add7b1cd5d3ca2bc8e5b329382ea2c7b
PYTHON_MEMORY_PROFILER_SETUP_TYPE = setuptools
PYTHON_MEMORY_PROFILER_LICENSE = BSD-3-Clause
PYTHON_MEMORY_PROFILER_LICENSE_FILES = COPYING

$(eval $(python-package))
