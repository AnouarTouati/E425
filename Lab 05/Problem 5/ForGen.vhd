Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity ForGen is
	Port(
		w:in std_logic_vector(4 downto 0);
		y:out std_logic_vector(31 downto 0));
End Entity;
Architecture bhv of ForGen is
	component Decoder24 is
		port(
		w:std_logic_vector(1 downto 0);
		y:out std_logic_vector(3 downto 0));
	End component;
	component Decoder38 is
		port(CE:std_logic;
		w:std_logic_vector(2 downto 0);
		y:out std_logic_vector(7 downto 0));
	End component;
	signal modIN :std_logic_vector(2 downto 0) := (others=>'0');
	signal dec :std_logic_vector(7 downto 0) := (others=>'0');
Begin
	-- for generate used to generate multiple components.
	Dec1 : Decoder38 port map ('1','0' & w(4 downto 3),dec);
	GEN_REG:  for k in 0 to 3 generate
		--connect outputs of 3:8 decoder to the chip enable of the 3:8 decoders
		DecN : Decoder38 port map (dec(k),w(2 downto 0),y(k*8+7 downto k*8));
	end generate;
	--				--| DEC 3:8|
	--			 	--| DEC 3:8|
	--	|DEC 3:8|						==  |DEC 5:32|
	--				--| DEC 3:8|
	--				--| DEC 3:8|
End Architecture;
