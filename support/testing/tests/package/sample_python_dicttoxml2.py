from dicttoxml2 import dicttoxml

payload: dict = {'mylist': ['foo', 'bar', 'baz'], 'mydict': {'foo': 'bar', 'baz': 1}, 'ok': True}

expected: bytes = b'<?xml version="1.0" encoding="UTF-8" ?><root><mylist type="list"><item type="str">' \
                  b'<![CDATA[foo]]></item><item type="str"><![CDATA[bar]]></item><item type="str"><![CDATA[baz]]>' \
                  b'</item></mylist><mydict type="dict"><foo type="str"><![CDATA[bar]]></foo><baz type="int">' \
                  b'<![CDATA[1]]></baz></mydict><ok type="bool"><![CDATA[True]]>' \
                  b'</ok></root>'

assert dicttoxml(payload, cdata=True) == expected
