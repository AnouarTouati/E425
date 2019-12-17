Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
Entity MyMemory is
	Port(OE,LE :in std_logic;
		w:in Integer;
		y:out std_logic_vector(6 downto 0));
End Entity;

Architecture bhv of MyMemory is
Type room_type is array(0 to 15) of std_logic_vector(6 downto 0);
constant  myROM :room_type := ("0000001","1001111","0010010","0000110",
								"1001100","0100100","0100000","0001111",
								"0000000","0000100","0000010","1100000",
								"0110001","1000010","0110000","0111000");
Begin
	Process (w,OE,LE) is
	Begin
		If OE='1' Then--if OE is not active
			y <=(others=>'Z');--High Impedance output
		Elsif LE='0' Then--if OE is active
			y <=(others=>'0');--High Impedance output
		Else
			y <= myROM(w);
		End if;
	End Process;
	
End;

