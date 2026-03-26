################################################################################
#
# llvm-project
#
################################################################################

LLVM_PROJECT_VERSION_MAJOR = 22
LLVM_PROJECT_VERSION = $(LLVM_PROJECT_VERSION_MAJOR).1.2
LLVM_PROJECT_SITE = https://github.com/llvm/llvm-project/releases/download/llvmorg-$(LLVM_PROJECT_VERSION)
LLVM_PROJECT_SOURCE = llvm-project-$(LLVM_VERSION).src.tar.xz

include $(sort $(wildcard package/llvm-project/*/*.mk))
