import jmespath
expression = jmespath.compile('foo.bar')
res = expression.search({'foo': {'bar': 'baz'}})
assert res == "baz", "expression.search failed"
