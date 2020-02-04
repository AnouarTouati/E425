Library ieee;
use ieee.std_logic_1164.all;
use work.Pack.all;--include "Pack" package from the working directory.
Entity PackUsage is
	Port(
		w:in std_logic_vector(7 downto 0);
		NumberOfOnes:out integer;
		ByteToINT:out integer;
		NumOfTrailing:out integer);
End Entity;
Architecture bhv of PackUsage is
Begin
	--calling functions and procedures from the package.
	ByteToINT <= ByteToInteger(w);
	OnesCount(w,NumberOfOnes);
	TrailingZeros(w,NumOfTrailing);
End Architecture;

