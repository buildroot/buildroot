#! /bin/sh

# The call to fbv must be backgrounded
/usr/bin/fbv /splash.png &
/bin/sleep 5
exec /sbin/init
