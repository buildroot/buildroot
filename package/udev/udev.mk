################################################################################
#
# udev
#
################################################################################

# Required by default rules for input devices
define UDEV_USERS
	- - input -1 * - - - Input device group
	- - render -1 * - - - DRI rendering nodes
	- - kvm -1 * - - - kvm nodes
	- - sgx -1 * - - - SGX device nodes
endef

$(eval $(virtual-package))
