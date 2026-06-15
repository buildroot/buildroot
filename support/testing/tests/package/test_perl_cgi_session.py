from tests.package.test_perl import TestPerlBase


class TestPerlCGISession(TestPerlBase):
    """
    package:
        CGI-Session
    direct dependencies:
        CGI
    indirect dependencies:
        Clone   XS
        Encode-Locale
        HTML-Parser   XS
        HTML-Tagset
        HTTP-Date
        HTTP-Message
        IO-HTML
        LWP-MediaTypes
        MIME-Base32
        TimeDate
        URI
    """

    config = TestPerlBase.config + \
        """
        BR2_PACKAGE_PERL=y
        BR2_PACKAGE_PERL_CGI_SESSION=y
        """

    def test_run(self):
        self.login()
        self.module_test("Clone")
        self.module_test("HTML::Parser")
        self.module_test("CGI::Session")
