Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
Entity Problem05 is
	Port(
		w:in Integer range 0 to 9;--Input value (x).
		y:out std_LOGIC_vector(9 downto 0));--output value of the polynomial.
End Entity;

Architecture bhv of Problem05 is
Type room_type is array(0 to 9) of std_LOGIC_vector(9 downto 0);--Defining the ARRAY for the ROM. 
constant  myROM :room_type := ( -- Intializing the ROM as a Lookup Table
				std_logic_vector(to_unsigned(6,10)),
				std_logic_vector(to_unsigned(15,10)),
				std_logic_vector(to_unsigned(36,10)),
				std_logic_vector(to_unsigned(75,10)),
				std_logic_vector(to_unsigned(138,10)),
				std_logic_vector(to_unsigned(231,10)),
				std_logic_vector(to_unsigned(360,10)),
				std_logic_vector(to_unsigned(531,10)),
				std_logic_vector(to_unsigned(750,10)),
				std_logic_vector(to_unsigned(1023,10)));
				
Begin
	Process (w) is
	Begin
		y <= myROM(w);--Read from the ROM
	End Process;
	
End;

