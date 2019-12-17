Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
Entity MyMemory is
	Port(CE,RW :in std_logic;
		Address:in Integer range 0 to 31;
		DataIn:in std_logic_vector(3 downto 0);
		DataOut:out std_logic_vector(3 downto 0));
End Entity;

Architecture bhv of MyMemory is
Type ram_type is array(0 to 31) of std_logic_vector(3 downto 0);
signal  myRAM : ram_type;
Begin
	Process (Address,DataIn,CE,RW) is
	Begin
		If CE='1' Then--if CE is low
			DataOut <=(others=>'Z');--High Impedance output
		Else
			If RW='0' Then--if OE is active
				DataOut <= myRAM(Address);
			Else
				myRAM(Address) <= DataIn;
				DataOut <=(others=>'Z');
			End if;
		End if;
	End Process;
	
End;

