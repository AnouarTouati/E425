Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
Entity MyMemory is
	Port(OE,LE :in std_logic;
		w:in std_logic_vector(3 downto 0);
		y:out std_logic_vector(6 downto 0));
End Entity;

Architecture bhv of MyMemory is
Begin
	Process (w,OE,LE) is
	Begin
		If OE='1' Then--if OE is not active
			y <=(others=>'Z');--High Impedance output
		Elsif LE='0' Then--if OE is active
			y <=(others=>'0');--High Impedance output
		Else
			Case w is
				when "0000" => y <= "0000001"; -- "0"     
				when "0001" => y <= "1001111"; -- "1" 
				when "0010" => y <= "0010010"; -- "2" 
				when "0011" => y <= "0000110"; -- "3" 
				when "0100" => y <= "1001100"; -- "4" 
				when "0101" => y <= "0100100"; -- "5" 
				when "0110" => y <= "0100000"; -- "6" 
				when "0111" => y <= "0001111"; -- "7" 
				when "1000" => y <= "0000000"; -- "8"     
				when "1001" => y <= "0000100"; -- "9" 
				when "1010" => y <= "0000010"; -- "a"
				when "1011" => y <= "1100000"; -- "b"
				when "1100" => y <= "0110001"; -- "C"
				when "1101" => y <= "1000010"; -- "d"
				when "1110" => y <= "0110000"; -- "E"
				when "1111" => y <= "0111000"; -- "F"
			End Case;
		End if;
	End Process;
	
End;

