################################################################################
#
# python-memory-profiler
#
################################################################################

PYTHON_MEMORY_PROFILER_VERSION = 0.60.0
PYTHON_MEMORY_PROFILER_SOURCE = memory_profiler-$(PYTHON_MEMORY_PROFILER_VERSION).tar.gz
PYTHON_MEMORY_PROFILER_SITE = https://files.pythonhosted.org/packages/06/dd/7308a8ef1902db9d81c5bc226befe346a87ed8787caff00b8d91ed9f3b86
PYTHON_MEMORY_PROFILER_SETUP_TYPE = setuptools
PYTHON_MEMORY_PROFILER_LICENSE = BSD-3-Clause
PYTHON_MEMORY_PROFILER_LICENSE_FILES = COPYING

$(eval $(python-package))
