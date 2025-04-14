from tzlocal import get_localzone
from zoneinfo import ZoneInfo

tz = get_localzone()
assert tz == ZoneInfo(key='Europe/Berlin')
