Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
Entity RAM is
	Port(clk,RD,WE :in std_logic;
		Address:in Integer range 0 to 3;
		DataIn:in std_logic_vector(7 downto 0);
		DataOut:out std_logic_vector(7 downto 0));
End Entity;

Architecture bhv of RAM is
Type ram_type is array(0 to 3) of std_logic_vector(7 downto 0) ;
signal  myRAM : ram_type ;
Begin
	Process (clk,RD) is
	Begin
		
		if clk'event and clk = '1' Then
			If RD='1' Then
				DataOut <= myRAM(Address);
			elsif WE = '1' Then
				myRAM(Address) <= DataIn;
			Else
				DataOut <= (others=>'Z');
			End if;
		End if;
	End Process;
	
End;
