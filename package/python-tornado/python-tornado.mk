################################################################################
#
# python-tornado
#
################################################################################

PYTHON_TORNADO_VERSION = 6.4.2
PYTHON_TORNADO_SOURCE = tornado-$(PYTHON_TORNADO_VERSION).tar.gz
PYTHON_TORNADO_SITE = https://files.pythonhosted.org/packages/59/45/a0daf161f7d6f36c3ea5fc0c2de619746cc3dd4c76402e9db545bd920f63
PYTHON_TORNADO_LICENSE = Apache-2.0
PYTHON_TORNADO_LICENSE_FILES = LICENSE
PYTHON_TORNADO_CPE_ID_VENDOR = tornadoweb
PYTHON_TORNADO_CPE_ID_PRODUCT = tornado
PYTHON_TORNADO_SETUP_TYPE = setuptools

# 0001-httputil-raise-errors-instead-of-logging-in.patch
PYTHON_TORNADO_IGNORE_CVES += CVE-2025-47287

# 0002-web-Harden-against-invalid-HTTP-reason-phrases.patch
PYTHON_TORNADO_IGNORE_CVES += CVE-2025-67724

# 0003-httputil-Fix-quadratic-behavior-in-parseparam.patch
PYTHON_TORNADO_IGNORE_CVES += CVE-2025-67725 CVE-2025-67726

$(eval $(python-package))
