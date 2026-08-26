#!/usr/bin/env python3
"""A simple test that uses python-gobject to find the path of sh."""
from gi.repository import GLib


def main():
    # In Glib >= 2.88, GLib.unix_signal_add has been moved to a
    # separate platform-specific library. This break backward
    # compatibility from GLib-2.0.
    # A workaround has been applied to pygobject >= 3.55.3
    # https://gitlab.gnome.org/GNOME/pygobject/-/commit/74e4e0f40a66436a55c72d4a6e6058c1f91a7310
    unix_signal_add = GLib.unix_signal_add_full  # noqa
    sh_path = GLib.find_program_in_path('sh')
    if sh_path == "/bin/sh":
        return True
    return False


if __name__ == '__main__':
    main()
