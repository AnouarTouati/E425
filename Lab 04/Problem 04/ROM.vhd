Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
Entity ROM is
	Port(clk,RD :in std_logic;
		Address:in Integer range 0 to 3;
		DataOut:out std_logic_vector(7 downto 0));
End Entity;

Architecture bhv of ROM is
Type ram_type is array(0 to 3) of std_logic_vector(7 downto 0) ;
signal  myRAM : ram_type := (x"C0",x"D1",x"E2",x"F3");
Begin
	Process (RD,Address) is
	Begin
		If RD='1' Then
			DataOut <= myRAM(Address);
		Else
			DataOut <= (others=>'Z');
		End if;
	End Process;
	
End;
