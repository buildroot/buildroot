from crc import Calculator, Crc8

expected = 0xBC
data = bytes([0, 1, 2, 3, 4, 5])
calculator = Calculator(Crc8.CCITT)

assert expected == calculator.checksum(data)
