#!/bin/bash
# This is taken from 
# https://stackoverflow.com/questions/7244321/how-do-i-update-a-github-forked-repository
#
# In your local clone of your forked repository, you can add the original GitHub repository 
#  as a "remote". ("Remotes" are like nicknames for the URLs of repositories - origin is one, 
#  for example.) Then you can fetch all the branches from that upstream repository, and 
#  rebase your work to continue working on the upstream version. In terms of commands 
#  that might look like:
#
#

git remote -v | grep "https://github.com/buildroot/buildroot.git (fetch)" &> /dev/null
if [ $? == 0 ]; then
	echo "remote upstream already exist "
else
	echo "Add the remote, call it upstream:"
	git remote add upstream https://github.com/buildroot/buildroot.git
fi

# Fetch all the branches of that remote into remote-tracking branches,
# such as upstream/master:
git fetch upstream

# Make sure that you're on your master branch:
git checkout master

# Rewrite your master branch so that any commits of yours that
# aren't already in upstream/master are replayed on top of that
# other branch:
git rebase upstream/master

#If you don't want to rewrite the history of your master branch, (for example 
# because other people may have cloned it) then you should replace the last 
# command with git merge #upstream/master. However, for making further pull 
# requests that are as clean as possible, it's probably better to rebase.

#If you've rebased your branch onto upstream/master you may need to 
# force the push in order to push it to your own forked repository on GitHub. You'd do that with:
git push -f origin master

#You only need to use the -f the first time after you've rebased.

