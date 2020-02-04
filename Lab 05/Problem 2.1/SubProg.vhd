Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
Entity SubProg is
	Port(
		w:in BIT_VECTOR(7 downto 0);
		y:out BIT);
End Entity;

Architecture bhv of SubProg is
	Function ParityCheck(w:BIT_VECTOR(7 downto 0)) return BIT is
		variable par:BIT := '1';
		begin
			for k in w'range loop
				if w(k)='1' Then
					par := not par;
				end if;
			end loop;
			return par;
	End Function;
Begin
	y <= ParityCheck(w);
End;
