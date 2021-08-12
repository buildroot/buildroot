#
# Reads a include file and tries to set all the variable found.
#
# $1: nexus include file
#
get_nexus_version = \
	__inc_file=`find ${@D}/nexus -name platform_version.inc` ; \
	if [[ ! -f $${__inc_file} ]] ; then \
		exit -1; \
	fi ; \
	__major=$(strip `cat $${__inc_file} | grep NEXUS_PLATFORM_VERSION_MAJOR | awk '{print $$3}'`) ; \
	__minor=$(strip `cat $${__inc_file} | grep NEXUS_PLATFORM_VERSION_MINOR | awk '{print $$3}'`) ; \
	printf "$${__major}.$${__minor}" 

