from diskcache import Cache

cache = Cache()

cache['test'] = 123
assert cache['test'] == 123
del cache['test']
assert 'test' not in cache
cache.close()
