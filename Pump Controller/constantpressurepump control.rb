#simplest ruby program to read from arduino serial, 
#using the SerialPort gem
#(http://rubygems.org/gems/serialport)

require "serialport"

#params for pressure serial port
port_str = "/dev/ttyUSB0"  #may be different for you
baud_rate = 9600
data_bits = 8
stop_bits = 1
parity = SerialPort::NONE

sp = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

#continously running program
while true do
  #measure pressure from Arduino connected to serial port.
  while (pressure = sp.gets.chomp) do       # see note 2
    puts pressure
    #puts i.class #String
  end
    
  #Takes the pressure reading and increases or decreases infuse rate to obtain desired pressure
  if pressure < target_pressure
    #serial write increase infuse rate (i need something here that picks how much the rate should change.)
  else if pressure > target_pressure 
    #serial write decrease infuse rate
  end
end

sp.close                       #see note 1