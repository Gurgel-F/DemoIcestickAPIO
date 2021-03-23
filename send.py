# pip3 install --user pyserial
# https://pyserial.readthedocs.io/en/latest/pyserial_api.html
import serial

baud_rate = 9600
timeout = 0.2

message = bytearray()
message.append(0x00)
message.append(0x45)
message.append(0x39)
message.append(0x65)
message.append(0x00)

with serial.Serial('/dev/ttyUSB1', baud_rate, stopbits=serial.STOPBITS_TWO, timeout=timeout) as ser:
	ser.write(message)

