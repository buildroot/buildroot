# example from https://pypi.org/project/pathspec/

import pathspec

# The gitignore-style patterns for files to select, but we're including
# instead of ignoring.
spec_text = """

# This is a comment because the line begins with a hash: "#"

# Include several project directories (and all descendants) relative to
# the current directory. To reference a directory you must end with a
# slash: "/"
/project-a/
/project-b/
/project-c/

# Patterns can be negated by prefixing with exclamation mark: "!"

# Ignore temporary files beginning or ending with "~" and ending with
# ".swp".
!~*
!*~
!*.swp

# These are python projects so ignore compiled python files from
# testing.
!*.pyc

# Ignore the build directories but only directly under the project
# directories.
!/*/build/

"""

spec = pathspec.PathSpec.from_lines('gitwildmatch', spec_text.splitlines())
