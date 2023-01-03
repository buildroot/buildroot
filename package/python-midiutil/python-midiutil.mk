################################################################################
#
# python-midiutil
#
################################################################################

PYTHON_MIDIUTIL_VERSION = 1.2.1
PYTHON_MIDIUTIL_SOURCE = MIDIUtil-$(PYTHON_MIDIUTIL_VERSION).tar.gz
PYTHON_MIDIUTIL_SITE = https://files.pythonhosted.org/packages/f5/44/fde6772d8bfaea64fcf5eb948124d0a5fdf5f848b14ac22a23ced53e562d
PYTHON_MIDIUTIL_SETUP_TYPE = setuptools
PYTHON_MIDIUTIL_LICENSE = MIT
PYTHON_MIDIUTIL_LICENSE_FILES = License.txt

$(eval $(python-package))
