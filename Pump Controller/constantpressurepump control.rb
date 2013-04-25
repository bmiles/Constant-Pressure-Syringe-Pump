#Ruby program that reads pressure from Arduino serial port and uses this to control  
#using the SerialPort gem
#(http://rubygems.org/gems/serialport)

require "serialport"
#methods for pump control
def getRate
 pump_port.write("crate")
 pump_port.gets.chomp
end

def setRate(rate, units)
 pump_port.write("irate [{#{rate}} {#{rate units}}]")
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

pump_port = SerialPort.new(port_str, baud_rate, data_bits, stop_bits, parity)

#Run's at start up.
setRate(25, "µl/min")
pump_port.write("irun")

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

#PIDcontrol
istate = 0
lastPressure = 0

pgain = 2
igain = 1
dgain = 0


error = target_pressure - pressure

pTerm = pgain * error

iState += error

windupGaurd = WINDUP_GUARD_GAIN / igain;  

  if (iState > windupGaurd) 
    iState = windupGaurd;
  else if (iState < -windupGaurd) 
    iState = - windupGaurd;
  end
  
iTerm = igain * iState;

dterm = (dgain * (pressure - lastPressure))

lastPressure = pressure

return pTerm + iTerm - dTerm

pressureport.close                       #see note 1