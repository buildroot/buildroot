#!/bin/bash

read_config () {
    local  __resultvar=$1

    config_file=`find $2  -name nexus_config.h`

    while read -r line
    do
       defines+=`echo $line | awk 'match($0, /#define\s+(\w+)\s*(.*)/, a) { if (a[2] != "") {print "-D"a[1]"="a[2]}}'`
    done < "$config_file"

    eval $__resultvar="'$defines'"
}

parse_platform_app () {
  local  __resultvar=$1

  platform_app=`find $2/include  -name platform_app.inc`
  tmp_file="/tmp/"`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1`

  while read -r line
  do
    if [[ $line =~ "=" ]]; then
      sanitized=`echo $line | sed -E 's;\s+[?]*[=]+\s*;=\";'`
      echo $sanitized'"' >> $tmp_file
    fi
  done < "$platform_app"

  eval $__resultvar="'$tmp_file'"
}


##############################################################################
# IN 1 Location where platform_app.inc can be found
# IN 2 Location of nexus.pc.template
# IN 3 Location where to output th pc files
##############################################################################
generate () {
       template_pc="$2"

       parse_platform_app safe_platform_app "$1"
       source $safe_platform_app

       for f in $NEXUS_CFLAGS
       do
         if [[ $f == -D*  &&  $f != -D_* ]]; then
            defines+=" $f"
         fi
         if [[ $f == -I* ]]; then
            includes+=" $f"
         fi
       done

       sed -e "s;%VERSION_MAJOR%;${NEXUS_PLATFORM_VERSION_MAJOR};g" \
           -e "s;%VERSION_MINOR%;${NEXUS_PLATFORM_VERSION_MINOR};g" \
           -e "s;%NAME%;nexus;g" \
           -e "s;%DESCRIPTION%;Broadcom Nexus;g" \
           -e "s;%LIBS%;${NEXUS_LD_LIBRARIES};g" \
           -e "s;%INCLUDES%;${includes};g" \
           -e "s;%DEFINES%;${defines};g" \
           "$template_pc" > "$3"/nexus.pc
           
       sed -e "s;%VERSION_MAJOR%;${NEXUS_PLATFORM_VERSION_MAJOR};g" \
           -e "s;%VERSION_MINOR%;${NEXUS_PLATFORM_VERSION_MINOR};g" \
           -e "s;%NAME%;nexus-client;g" \
           -e "s;%DESCRIPTION%;Broadcom Nexus Client;g" \
           -e "s;%LIBS%;${NEXUS_CLIENT_LD_LIBRARIES};g" \
           -e "s;%INCLUDES%;${includes};g" \
           -e "s;%DEFINES%;${defines};g" \
           "$template_pc" > "$3"/nexus-client.pc
           
       rm $safe_platform_app
}

generate $@
