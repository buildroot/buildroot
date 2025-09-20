import os
import subprocess

import infra


GIT_HOST_DIR = "host"
GIT_CONFIG_DIR = os.path.join(GIT_HOST_DIR, "home/br-user")
GIT_CONFIG_FILE = os.path.join(GIT_CONFIG_DIR, "gitconfig")


def run_git_config(logfile, cmd):
    logfile.write(
        "> running git config with '{}'\n".format(" ".join(cmd)))
    try:
        subprocess.check_call(cmd, stdout=logfile, stderr=logfile)
    except FileNotFoundError:
        logfile.write("> git config failed\n")
        raise SystemError("git config failed")


def generate_gitconfig(builddir, logtofile, gitremotedir):
    logfile = infra.open_log_file(builddir, "gitconfig", logtofile)

    # The git repository used by this test is cloned locally from
    # gitremotedir using the "file://" protocol. Since it contains
    # several git submodules we need to allow this protocol to be used
    # with git submodules. Since we don't want to modify the user
    # (global) gitconfig, we use a local gitconfig file.
    localgitconfig = os.path.join(builddir, GIT_CONFIG_FILE)

    gitconfigdir = os.path.join(builddir, GIT_CONFIG_DIR)
    os.makedirs(gitconfigdir, exist_ok=True)

    # We are using the git repository from the Buildroot git tree
    # (gitremotedir). This repository is safe to use using "file://"
    # protocol with git submodules.
    cmd = ["git", "config", "--file", localgitconfig,
           "--add", "protocol.file.allow", "always"]

    run_git_config(logfile, cmd)

    # Disable ownership check of the git tree for Gitlab-CI
    # environment.
    # See: https://gitlab.com/buildroot.org/buildroot/-/commit/a016b693f7830f3c8ae815851d3204b8b6e99821
    for git_repo in os.scandir(gitremotedir):

        cmd = ["git", "config", "--file", localgitconfig,
               "--add", "safe.directory", git_repo.path]

        run_git_config(logfile, cmd)
