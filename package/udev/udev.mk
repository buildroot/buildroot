################################################################################
#
# udev
#
################################################################################

# Required by default rules
define UDEV_USERS
	- - input -1 * - - - Input device group
	- - kvm -1 * - - - kvm nodes
endef

$(eval $(virtual-package))
