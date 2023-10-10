#! /bin/sh

# The call to fbv must be backgrounded
fbv /splash.png &
exec /sbin/init
