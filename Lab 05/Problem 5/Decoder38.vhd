Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
Entity Decoder38 is
	Port(
		CE:std_logic;
		w:std_logic_vector(2 downto 0);
		y:out std_logic_vector(7 downto 0));
End Entity;
Architecture bhv of Decoder38 is
Begin
	Process(w) is
	variable output:std_logic_vector(7 downto 0) := (others=>'0');
	Begin
		output:= (others=>'0');
		if CE='1' Then
			output(to_integer(unsigned(w))):= '1';
		End if;
		y <= output;
	End Process;
End Architecture;