################################################################################
#
# python-memory-profiler
#
################################################################################

PYTHON_MEMORY_PROFILER_VERSION = 0.58.0
PYTHON_MEMORY_PROFILER_SOURCE = memory_profiler-$(PYTHON_MEMORY_PROFILER_VERSION).tar.gz
PYTHON_MEMORY_PROFILER_SITE = https://files.pythonhosted.org/packages/8f/fd/d92b3295657f8837e0177e7b48b32d6651436f0293af42b76d134c3bb489
PYTHON_MEMORY_PROFILER_SETUP_TYPE = setuptools
PYTHON_MEMORY_PROFILER_LICENSE = BSD-3-Clause
PYTHON_MEMORY_PROFILER_LICENSE_FILES = COPYING

$(eval $(python-package))
