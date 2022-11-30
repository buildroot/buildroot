# Inspired from https://construct.readthedocs.io/en/latest/intro.html#example
import construct

format = construct.Struct(
    "signature" / construct.Const(b"BMP"),
    "width" / construct.Int8ub,
    "height" / construct.Int8ub,
    "pixels" / construct.Array(construct.this.width * construct.this.height, construct.Byte),
)
a = format.build(dict(width=3,height=2,pixels=[7,8,9,11,12,13]))
assert(a == b'BMP\x03\x02\x07\x08\t\x0b\x0c\r')
b = format.parse(b'BMP\x03\x02\x07\x08\t\x0b\x0c\r')
assert(b.signature == b'BMP')
assert(b.width == 3)
assert(b.height == 2)
assert(b.pixels == [7, 8, 9, 11, 12, 13])
