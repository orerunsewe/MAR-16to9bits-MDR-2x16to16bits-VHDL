 This is a VHDL description of a positive-edge triggered 16-bit input to 9-bit output Memory Address Register (MAR) and a Memory Data Register with  two 16-bit inputs and a 16-bit output. Both the MAR and MDR have synchronous control signals: reset and enable. When reset = 0, output = 0 for both MDR and MAR. For the MAR, when enable = 1, output is the 9 LSB of input and when enable = 0, output is isolated(high impedance denoted by 'ZZZZZZZZZ'). For the MDR, when enable = 1, output is the first 16 bit input and when enable = 0, output latches to the second 16-bit input. 

Test vectors are generated using MATLAB and the input/expected output files are tested in the VHDL testbench to see if outputs from VHDL description matches with expected output generated from MATLAB.

entity description and architecture are both in the .vhd files 

Pictures of the data flow schematics have been added for both MAR and MDR.
