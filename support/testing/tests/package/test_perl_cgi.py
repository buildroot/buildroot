from tests.package.test_perl import TestPerlBase


class TestPerlCGI(TestPerlBase):
    """
    package:
        CGI
    direct dependencies:
        HTML-Parser   XS
        URI
    indirect dependencies:
        Clone   XS
        Encode-Locale
        HTML-Tagset
        HTTP-Date
        HTTP-Message
        IO-HTML
        LWP-MediaTypes
        MIME-Base32
        TimeDate
    """

    config = TestPerlBase.config + \
        """
        BR2_PACKAGE_PERL=y
        BR2_PACKAGE_PERL_CGI=y
        """

    def test_run(self):
        self.login()
        self.module_test("Clone")
        self.module_test("HTML::Parser")
        self.module_test("CGI")
