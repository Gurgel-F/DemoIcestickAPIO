import serial
import binascii

baud_rate = 9600
timeout = 0.5

with serial.Serial('/dev/ttyUSB1', baud_rate, timeout=timeout, stopbits=serial.STOPBITS_TWO) as ser:
    try:
        while True:
            data = ser.read(1)
            if data:
	            print(binascii.hexlify(data), end=' ', flush=True)
    except KeyboardInterrupt:
        print()
        print('Interrupted')
