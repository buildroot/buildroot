################################################################################
#
# python-ipython-pygments-lexers
#
################################################################################

PYTHON_IPYTHON_PYGMENTS_LEXERS_VERSION = 1.1.1
PYTHON_IPYTHON_PYGMENTS_LEXERS_SOURCE = ipython_pygments_lexers-$(PYTHON_IPYTHON_PYGMENTS_LEXERS_VERSION).tar.gz
PYTHON_IPYTHON_PYGMENTS_LEXERS_SITE = https://files.pythonhosted.org/packages/ef/4c/5dd1d8af08107f88c7f741ead7a40854b8ac24ddf9ae850afbcf698aa552
PYTHON_IPYTHON_PYGMENTS_LEXERS_SETUP_TYPE = flit
PYTHON_IPYTHON_PYGMENTS_LEXERS_LICENSE = BSD-3-Clause
PYTHON_IPYTHON_PYGMENTS_LEXERS_LICENSE_FILES = LICENSE

$(eval $(python-package))
