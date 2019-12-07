Library IEEE;--Including IEEE library.
use IEEE.std_logic_1164.all;-- Including std_logic_1164 package.
use ieee.std_logic_unsigned.all;-- Including std_logic_unsigned package.
Entity myFSM is--Entity declaration.
	Port(Rst,clk:in std_logic;
		NSLights:out std_logic_vector(2 downto 0);-- North-South Red-Orange-Green lights
		EWLights:out std_logic_vector(2 downto 0);-- East-West Red-Orange-Green lights
		Hexrest: out std_logic_vector(7 downto 0));--signal connected to the rest of Seven Segment pins.
End Entity;

Architecture fsm of myFSM is
TYPE State is (S0,S1,S2,S3);
signal PS:State := S0;
signal Fast_Counter:std_logic_vector(25 downto 0):= (others=>'0');
signal Fast_Counter2:std_logic_vector(2 downto 0):= (others=>'0');
signal Timer_Q2,Clk_slow :std_logic;

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
	-- Clock Divider Process of (Mod 8).
	Process(Clk_slow,Rst)
	Begin
		if Rst = '1' Then
			Fast_Counter2 <= (others=>'0');
		Elsif Fast_Counter2 = 5 Then 
			Fast_Counter2 <= (others=>'0');
		Elsif Clk_slow'event and Clk_slow='1' Then
			Fast_Counter2 <= Fast_Counter2 + 1;
		End if;
	End Process;
	Timer_Q2 <= Fast_Counter2(2);
	
	Process (Clk_slow,Rst) is--Define Process which sensetive to Clk_slow and Rst.
	Begin
		if Rst='1' Then 
			PS <= S0;--go to the initial state A.
			Counter <= (others=>'0');--reset the counter.
		Elsif Clk_slow'event and Clk_slow='1' Then
			Case PS is
				When S0 =>-- if present state is S0:
					if Timer_Q2='1' Then --if Timer_Q2
						PS<=S1;-- Go to state S1
						NSLights<= "011"; --and change the output in the transition.
						EWLights<= "101";
					Else
						PS<=S0;--otherwise go back to state S0.
						NSLights<= "011";--and change the output in the transition.
						EWLights<= "110";
					End if;
				When S1 =>
					PS<=S2;-- Go to state S2
					NSLights<= "110";
					EWLights<= "011";
				When S2 =>
					if Timer_Q2='1' Then 
						PS<=S3;
						NSLights<= "101";
						EWLights<= "011";
					Else
						PS<=S2;
						NSLights<= "110";
						EWLights<= "011";
					End if;
				When S3 =>
					PS<=S0;
					NSLights<= "011";
					EWLights<= "110";
			End Case;
		End if;
	End Process;
	
	Hexrest <= (others=>'1');--the rest pins of seven segment are always HIGH.
	
End;

