Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
Entity SubProg is
	Port(
		w:in std_logic_VECTOR(7 downto 0);
		y:out integer);
End Entity;

Architecture bhv of SubProg is
	Function ByteToInteger(w:std_logic_VECTOR(7 downto 0)) return integer is
	begin
		return to_integer(unsigned(w));
	End Function;
Begin
	y <= ByteToInteger(w);
End;
