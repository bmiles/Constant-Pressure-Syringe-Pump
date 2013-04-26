Constant-Pressure-Syringe-Pump
==============================

This is a ruby program to drive a syringe pump based on data fed to it by an Arduino pressure sensor.

The Havard Apparatus PHD pump is connected via RS-232 to the computer.

The program executes a pre determined program based on PID control of pressure, using the pressure from the arduino as
input and infuse rate as the output.
