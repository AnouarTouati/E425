Library IEEE;--Including IEEE library.
use IEEE.std_logic_1164.all;-- Including std_logic_1164 package.
use ieee.std_logic_unsigned.all;-- Including std_logic_unsigned package.
Entity myFSM is--Entity declaration.
	Port(ENA,Rst,clk:in std_logic;
		y:out std_logic);
End Entity;

Architecture fsm of myFSM is
TYPE State is (A,B,C);--define enumerated data type for the FSM.
signal PS:State := A;--declare a signal as FSM type and initialize it.
signal Fast_Counter:std_logic_vector(25 downto 0):= (others=>'0');--define 26 bit counter.
signal Clk_slow :std_logic;--define signal as the devided clock

signal Counter :std_logic_vector(3 downto 0):= (others=>'0');
Begin
	-- Clock Divider Process of 50 Million.
	Process(clk,rst)--Define Process which sensetive to Clk and Rst.
	Begin
		if rst='1' Then--If Asychronous Rst is High.
			Fast_Counter <=(others=>'0');--reset the 26bit counter.
		elsif Fast_Counter = 50000000 Then-- if 50M has been reached
			Fast_Counter <=(others=>'0');--reset the 26bit counter.
		Elsif Clk'event and Clk='1' Then--in the positive edge.
			Fast_Counter <= Fast_Counter + 1;--increament the 26bit counter.
		End if;
	End Process;
	Clk_slow <= Fast_Counter(25);--assign the highest significant bit to the slow clock.
	
	Process (Clk_slow,Rst) is--Define Process which sensetive to Clk_slow and Rst.
	Begin
		if Rst='1' Then --If Asychronous Rst is High.
			PS <= A;--go to the initial state A.
			Counter <= (others=>'0');--reset the counter.
		Elsif Clk_slow'event and Clk_slow='0' Then--in the negative edge.
			Case PS is
				When A =>-- if present state is A:
					if ENA='1' Then 
						PS<=B;
					End if;
				When B =>-- if present state is B:
					If ENA='0' Then --if ENA is LOW go back to A directly.
						PS<=A;
					Else-- if not wait for 7 seconds and go to state C.
						If Counter = 6 Then
							PS<=C;
							Counter <= (others=>'0');
						Else
							Counter <= Counter + 1;
						End if;
					End if;
				When C =>-- if present state is C:
					If ENA='0' Then --if ENA is LOW go back to A directly.
						PS<=A;
					Else-- if not wait for 3 seconds and go to state B.
						If Counter = 2 Then
							PS<=B;
							Counter <= (others=>'0');
						Else
							Counter <= Counter + 1;
						End if;
					End if;
			End Case;
		End if;
	End Process;
	y <= '1' when PS = B Else -- the output is HIGH only when present state is B.
		'0';
End;

