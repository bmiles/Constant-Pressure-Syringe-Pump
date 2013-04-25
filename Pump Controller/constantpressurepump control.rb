#simplest ruby program to read from arduino serial, 
#using the SerialPort gem
#(http://rubygems.org/gems/serialport)

require "serialport"

def getRate
 pumpport.write("crate")
 pumpport.gets.chomp
end

def setRate(rate, units)
 pumpport.write("irate [{#{rate}} {#{rate units}}]")
end

#params for pressure serial port
port_str = "/dev/ttyUSB0"  #may be different for you
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

pressureport = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

port_str = "/dev/ttyUSB0"  #may be different for you
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

pumpport = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

#continously running program
while true do
  #measure pressure from Arduino connected to serial port.
  while (pressure = pressureport.gets.chomp) do       # see note 2
    puts pressure
    #puts i.class #String
  end
    
  #Takes the pressure reading and increases or decreases infuse rate to obtain desired pressure
  if pressure < target_pressure
    pumpport.write ""#serial write increase infuse rate (i need something here that picks how much the rate should change.)
  else if pressure > target_pressure 
    #serial write decrease infuse rate
  end
end

pressureport.close                       #see note 1