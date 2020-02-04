Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
Package Pack is
	Function ParityCheck(w:std_logic_vector(7 downto 0)) return BIT;
	Function ByteToInteger(w:std_logic_VECTOR(7 downto 0)) return integer;
	Procedure OnesCount(w:std_logic_vector(7 downto 0);signal y:out integer);
	Procedure TrailingZeros(w: in std_logic_vector(7 downto 0);signal y:out integer);
End Pack;
Package body Pack is
	Function ParityCheck(w:std_logic_vector(7 downto 0)) return BIT is
		variable par:BIT := '1';
		begin
			for k in w'range loop
				if w(k)='1' Then
					par := not par;
				end if;
			end loop;
			return par;
	End Function;
	Function ByteToInteger(w:std_logic_VECTOR(7 downto 0)) return integer is
	begin
		return to_integer(unsigned(w));
	End Function;
	Procedure OnesCount(w:std_logic_vector(7 downto 0);
						y:out integer)is
		
		variable num:integer := 0;
		begin
			for k in w'range loop
				if w(k)='1' Then
					num := num + 1;
				end if;
			end loop;
			y := num;
	End Procedure;
	Procedure TrailingZeros(w: in std_logic_vector(7 downto 0);
		y:out integer)is
		variable num:integer := 0;
		variable done : BIT := '0';
		begin
			for k in 0 to w'high loop
				if done = '0' Then
					if w(k)='0' Then
						num := num + 1;
					else
						done := '1';
					end if;
				end if;
			end loop;
			y := num;
	End Procedure;
End Pack;