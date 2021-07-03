#KERNEL_MODULE_SITE = $(KERNEL_MODULE_PKGDIR)
KERNEL_MODULE_SITE = ./package/kernel_module
KERNEL_MODULE_SITE_METHOD = local
$(eval $(kernel-module))
$(eval $(generic-package))
