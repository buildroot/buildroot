# Security Policy

## Security advisories

Advisories for Buildroot security vulnerabilities are reported on the
developer's mailing list. A public archive can be consulted on
https://lists.buildroot.org/mailman/listinfo/buildroot

Buildroot itself has a CPE to track its published vulnerabilities:
https://nvd.nist.gov/products/cpe/search/results?namingFormat=2.3&keyword=buildroot

The Buildroot project provides some ways for its users to track known
vulnerabilites in the packages included in the generated images, see:
- https://nightly.buildroot.org/manual.html#_details_about_packages

In addition, detailed informations for all packages integrated with Buildroot
are updated daily on the following public web pages:
- https://security.buildroot.org/
- https://autobuild.buildroot.org/stats/

## Reporting a Vulnerability

To report a security vulnerability found in the Buildroot build system itself,
please send an email to [security@buildroot.org](mailto:security@buildroot.org).

This is a private mailing list contacting the Buildroot maintainers only.

## Vulnerabilities in packages

Buildroot is a build system that cross-compiles packages from third-party
sources. The Buildroot developers are not responsible for security
vulnerabilities in these packages. Such vulnerabilities should be reported
directly to the upstream project that maintains the affected package.

When vulnerabilities are fixed upstream, send a patch to update the affected
packages in Buildroot.
