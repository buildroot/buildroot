from munch import Munch

b = Munch()
b.hello = 'world'
assert b.hello == 'world'
b['hello'] += "!"
assert b.hello == 'world!'
b.foo = Munch(lol=True)
assert b.foo.lol is True
assert b.foo is b['foo']

assert sorted(b.keys()) == ['foo', 'hello']

b.update({'ponies': 'are pretty!'}, hello=42)
assert b == Munch({'ponies': 'are pretty!', 'foo': Munch({'lol': True}), 'hello': 42})

assert sorted([(k, b[k]) for k in b]) == [('foo', Munch({'lol': True})), ('hello', 42), ('ponies', 'are pretty!')]

format_munch = Munch(knights='lolcats', ni='can haz')
assert "The {knights} who say {ni}!".format(**format_munch) == 'The lolcats who say can haz!'
