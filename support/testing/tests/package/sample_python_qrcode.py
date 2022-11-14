import qrcode
import qrcode.image.svg
img = qrcode.make('Some data here', image_factory=qrcode.image.svg.SvgImage)
