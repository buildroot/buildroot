import augeas

a = augeas.Augeas(root="/")
hosts = a.match("/files/etc/hosts/*")
assert(hosts is not None)
assert(len(hosts) == 2)

assert(a.get("/files/etc/hosts/1/ipaddr") == "127.0.0.1")
assert(a.get("/files/etc/hosts/1/canonical") == "localhost")
