Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
Entity SubProg is
	Port(
		w:in std_logic_VECTOR(7 downto 0);
		y:out integer);
End Entity;

Architecture bhv of SubProg is
	Procedure ByteToInteger(w: in std_logic_VECTOR(7 downto 0);
							signal y:out integer) is
	begin
		y<= to_integer(unsigned(w));
	End Procedure;
Begin
	
	ByteToInteger(w,y);
End;
