Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
Entity MyMemory is
	Port(Clk,Reset,Haz,RightLight,LeftLight :in std_logic;
		y:out std_logic_vector(5 downto 0));
End Entity;

Architecture bhv of MyMemory is
Type room_type is array(0 to 9) of std_logic_vector(5 downto 0);
constant  myROM :room_type := ("000000","001000","011000","111000",--Sequence of Left (Starts from 0)
							   "000000","000100","000110","000111",--Sequence of Right(Starts from 4)
								"000000","111111");--Sequence Of Brake(Starts from 8)

signal Fast_Counter:std_logic_vector(25 downto 0):= (others=>'0');--define 25 bit counter.
signal Clk_slow :std_logic;--define signal as the devided clock
signal Counter :integer range 0 to 9:= 0;
TYPE State is (R,L,B,E,Off);
signal PS:State := Off;

Begin
	--Clock Divider
	Process(Clk)--Define Process which sensetive to Clk and Rst.
	Begin
		if Fast_Counter = 50000000 Then
			Fast_Counter <=(others=>'0');
		Elsif Clk'event and Clk='1' Then --in the positive edge.
			Fast_Counter <= Fast_Counter + 1;--increament the 25bit counter.
		End if;
	End Process;
	Clk_slow <= Fast_Counter(25);--assign the highest significant bit to the slow clock.
	

	Process(Clk)
	Begin
		If RightLight = '0' and LeftLight = '0' Then
			--reset the counter if both Right and Left Buttons are LOW
			Counter <= 0;
		ElsIf Clk'event and Clk='1' Then
			If Reset='1' Then
				y <= (others=>'0');
				Counter <= 0;
			ElsIf RightLight= '1' and LeftLight = '1' Then
				y <= (others=>'1');
			ElsIf Haz= '1' Then
				If Counter >= 1 Then
					Counter <= 0;
				Else
					Counter <= Counter + 1;
				End if;
				y <= myROM(Counter+8);
			ElsIf RightLight= '1' Then
				If Counter >= 4 Then
					Counter <= 0;
				Else
					Counter <= Counter + 1;
				End if;
				y <= myROM(Counter+4);
			ElsIf LeftLight= '1' Then
				If Counter >= 4 Then
					Counter <= 0;
				Else
					Counter <= Counter + 1;
				End if;
				y <= myROM(Counter);
			Else
				y <= (others=>'0');
				Counter <= 0;
			End if;
		End if;
	End Process;
End;

