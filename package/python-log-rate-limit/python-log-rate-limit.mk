################################################################################
#
# python-log-rate-limit
#
################################################################################

PYTHON_LOG_RATE_LIMIT_VERSION = 1.4.2
PYTHON_LOG_RATE_LIMIT_SOURCE = log_rate_limit-$(PYTHON_LOG_RATE_LIMIT_VERSION).tar.gz
PYTHON_LOG_RATE_LIMIT_SITE = https://files.pythonhosted.org/packages/0d/c2/d3c67f59b934d0edfc00a7cfcac56d17fa9b9832ba8e353217c93187e506
PYTHON_LOG_RATE_LIMIT_SETUP_TYPE = poetry
PYTHON_LOG_RATE_LIMIT_LICENSE = Apache-2.0
PYTHON_LOG_RATE_LIMIT_LICENSE_FILES = LICENSE

$(eval $(python-package))
