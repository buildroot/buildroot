# test from https://github.com/CESNET/libyang-python/blob/master/README.rst

import libyang
from xml.etree import ElementTree

ctx = libyang.Context()

module = ctx.parse_module_str('''
module example {
  namespace "urn:example";
  prefix "ex";
  container data {
    list interface {
      key name;
      leaf name {
        type string;
      }
      leaf address {
        type string;
      }
    }
    leaf hostname {
      type string;
    }
  }
}
''')

node = module.parse_data_dict({
    'data': {
        'hostname': 'foobar',
        'interface': [
            {'name': 'eth0', 'address': '1.2.3.4/24'},
            {'name': 'lo', 'address': '127.0.0.1'},
        ],
    },
})

xml = node.print_mem('xml', pretty=True)
tree = ElementTree.fromstringlist(xml)
assert tree.tag == '{urn:example}data'
assert tree.find('.//{*}hostname').text == 'foobar'
assert len(tree.find('.//{*}interface')) == 2

node.free()
ctx.destroy()
