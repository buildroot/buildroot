Thank you for opening a new issue. To help solve it faster and more easily,
please review this check-list, and fill in the sections below. Adapt as
needed.

Do not open an issue to request a new feature; instead, post a message to
[the mailing list](https://lists.buildroot.org/mailman/listinfo/buildroot).

_Note: issues missing any information may get closed without further ado._

---
### Check-list

- [ ] I did not find the issue in the existing issues
- [ ] I can reproduce the issue with unmodified Buildroot from [this
      repository](https://gitlab.com/buildroot.org/buildroot), not from a
      fork somewhere else
- [ ] I can reproduce the issue on the latest commit of the branch I'm using:
    - [ ] master
    - [ ] stable (i.e. 20NN.MM.x - please specify)
    - [ ] LTS (i.e. 20NN.02.x - please specify)
- [ ] I can reproduce the issue after running `make clean; make`
- [ ] I attached the full build log file (e.g. `make 2>&1 |tee build.log`)
- [ ] I attached a **minimal** defconfig file that can reproduce the
      issue (`make BR2_DEFCONFIG=$(pwd)/issue_defconfig savedefconfig`)
- [ ] I also attached the configuration for kconfig-based packages that
      are enabled (and necessary to reproduce the issue), most notably:
    - [ ] busybox
    - [ ] linux
    - [ ] uclibc
    - [ ] uboot
    - [ ] …

---
### What I did

- **Buildroot commit sha1**: _get this with `git describe HEAD`_
- **Distribution of the build machine**: _get this with `NAME` and `VERSION` from `/etc/os-release`_

_Here, describe what you did:_
- _any special environment variables: CC, CXX, TARGET, CROSS_COMPILE, etc…_
- _the commands you ran:_
    ```sh
    $ make [...]
    ```
- _anything else that you might think is important…_

---
### What happens

_Here, describe what happens that you believe was incorrect._

---
### What was expected

_Here, describe the behaviour you expected._

---
### Extra information

_Here, you may write additional information that does not fit above_
