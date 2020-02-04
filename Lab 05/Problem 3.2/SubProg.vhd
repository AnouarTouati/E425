Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
Entity SubProg is
	Port(
		w:in BIT_VECTOR(7 downto 0);
		y:out integer);
End Entity;

Architecture bhv of SubProg is
	Procedure OnesCount(w:BIT_VECTOR(7 downto 0);
						signal y:out integer)is
		
		variable num:integer := 0;
		begin
			for k in w'range loop
				if w(k)='1' Then
					num := num + 1;
				end if;
			end loop;
			y <= num;
	End Procedure;
Begin
	
	OnesCount(w,y);
		
End;
