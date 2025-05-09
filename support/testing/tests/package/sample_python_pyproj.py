from pyproj import CRS

# WGS 84 - World Geodetic System 1984, used in GPS
crs_4326 = CRS.from_epsg(4326)
assert crs_4326.name == "WGS 84"
