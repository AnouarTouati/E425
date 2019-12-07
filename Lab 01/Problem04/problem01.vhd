Library IEEE;--Including IEEE library.
use IEEE.std_logic_1164.all;-- Including std_logic_1164 package.
use IEEE.std_logic_unsigned.all;-- Including std_logic_unsigned package.
Entity problem01 is--Entity declaration.
	Port(UP,clk,rst :in std_logic;-- UP,Clk,Rst as inputs.
		y: out std_logic_vector(3 downto 0));--y[4] as output.
End Entity;
Architecture bhv of problem01 is
signal counter:std_logic_vector(24 downto 0):= (others=>'0');--define 25 bit counter.
signal Clk_slow :std_logic;--define signal as the devided clock
signal Slow_Counter :std_logic_vector(3 downto 0):= (others=>'0');--4bit counter
Begin
	Process(clk,rst)--Define Process which sensetive to Clk and Rst.
	Begin
		if rst='1' Then--If Asychronous Rst is High.
			counter <=(others=>'0');--reset the 25bit counter.
		Elsif Clk'event and Clk='1' Then --in the positive edge.
			counter <= counter + 1;--increament the 25bit counter.
		End if;
	End Process;
	Clk_slow <= counter(24);--assign the highest significant bit to the slow clock.
	Process(Clk_slow,rst)--Define Process which sensetive to Clk_slow and Rst.
	Begin
		if rst='1' Then--If Asychronous Rst is High.
			Slow_Counter <=(others=>'0');--reset the 4bit counter.
		Elsif Clk_slow'event and Clk_slow='1' Then--in the positive edge.
			if UP = '0' Then--if UP is low
				Slow_Counter <= Slow_Counter + 1; --increament the 4bit counter.
			Else--otherwise
				Slow_Counter <= Slow_Counter - 1; --decreament the 4bit counter.
			End if;
		End if;
	End Process;
	y <= Slow_Counter;--outputing the Slow_Counter
	
End;

