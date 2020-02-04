Library IEEE;
use IEEE.std_logic_1164.all;
Entity Memory is
	Port(Clk,RD,WE :in std_logic;--Clock and Read Enable and Write Enable.
		Address:in Integer range 0 to 3;--Input Address.
		DataIn:in std_logic_vector(7 downto 0);--Input Data.
		DataOut:out std_logic_vector(7 downto 0));--Ouput Data.
End Entity;

Architecture bhv of Memory is
Type ram_type is array(0 to 3) of std_logic_vector(7 downto 0) ;--Define a type for the RAM.
signal  myRAM : ram_type ;--declare the RAM.
Begin
	Process (Clk) is
	Begin
		
		if clk'event and clk = '1' Then--at positive clock edge.
			If RD='1' Then--if RD is HIGH.
				DataOut <= myRAM(Address);--Read from the RAM.
			Elsif WE = '1' Then--if WE is HIGH.
				myRAM(Address) <= DataIn;--Write to the RAM.
			Else
				DataOut <= (others=>'Z');--High impedance output.
			End if;
		End if;
	End Process;
	
End;
