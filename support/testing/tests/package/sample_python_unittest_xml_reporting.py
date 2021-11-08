import unittest
import xmlrunner


class Test1(unittest.TestCase):
    def test_something(self):
        self.assertTrue(True)


if __name__ == '__main__':
    unittest.main(testRunner=xmlrunner.XMLTestRunner(output='test-reports'))
