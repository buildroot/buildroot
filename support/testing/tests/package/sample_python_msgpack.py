import msgpack

packaed = msgpack.packb([1, 2, 3], use_bin_type=True)

assert msgpack.unpackb(packaed, raw=False) == [1, 2, 3]
