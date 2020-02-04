Library IEEE;
use IEEE.std_logic_1164.all;
Entity Memory is
	Port(Clk,RD :in std_logic;--Clock and Read Enable.
		Address:in Integer range 0 to 3;--Input Address.
		DataOut:out std_logic_vector(7 downto 0));--Ouput Data.
End Entity;

Architecture bhv of Memory is
Type ram_type is array(0 to 3) of std_logic_vector(7 downto 0) ;--Define a type for the ROM.
signal  myRAM : ram_type := (x"C0",x"D1",x"E2",x"F3");--Initialize the ROM.
Begin
	Process (Clk) is
	Begin
		
		if clk'event and clk = '0' Then--at negative clock edge.
			If RD='1' Then--if RD is HIGH.
				DataOut <= myRAM(Address);--Read from the ROM.
			Else
				DataOut <= (others=>'Z');--High impedance output.
			End if;
		End if;
	End Process;
	
End;
