# Check that we can import urllib3 even if we don't use all of it:
import urllib3

# Just check that we can create a PoolManager:
http = urllib3.PoolManager()

# Check if we can normalize URLs:
assert urllib3.util.url.parse_url("HTTPS://Example.Com/?Key=Value").url \
    == "https://example.com/?Key=Value"
