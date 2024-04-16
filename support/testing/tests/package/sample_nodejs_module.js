var assert = require('assert');
var lodash = require('lodash');
result = lodash.chunk(['a', 'b', 'c', 'd'], 2);
expected = [ [ 'a', 'b' ], [ 'c', 'd' ] ];
assert.deepStrictEqual(result, expected)


