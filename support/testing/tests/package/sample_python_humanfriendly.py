import humanfriendly as hf


h_size = "16MiB"
b_size = hf.parse_size(h_size)
assert b_size == 16*1024*1024
