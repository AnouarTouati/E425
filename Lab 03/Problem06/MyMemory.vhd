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


Begin
	--Clock Divider
	Process(Clk)
	Begin
		if Fast_Counter = 50000000 Then
			Fast_Counter <=(others=>'0');
		Elsif Clk'event and Clk='1' Then 
			Fast_Counter <= Fast_Counter + 1;
		End if;
	End Process;
	Clk_slow <= Clk;--Fast_Counter(25);--assign the highest significant bit to the slow clock.
	
	Process(Clk_slow)
	Begin
		If Clk_slow'event and Clk_slow='0' Then--in the raising edge :
			If Reset='1' Then --if reset is HIGH :
				Counter <= 8; -- Address to Turn off the lights
			ElsIf RightLight= '1' and LeftLight = '1' Then-- if Brake is ON:
				Counter <= 9; --Address to Turn on the lights
			ElsIf Haz= '1' Then -- If Hazard is ON:
				-- Toggle between Address 8 and 9 to get the Hazard outputs from the ROM
				If Counter = 8 Then
					Counter <= 9;
				Else
					Counter <= 8;
				End if;
			ElsIf RightLight= '1' Then -- If Trun Right is ON: 
				-- Keep alternating between Addresses 0 and 3 to get Turn Right outputs from ROM
				If Counter >= 4 Then
					Counter <= 0;
				Else
					Counter <= Counter + 1;
				End if;
			ElsIf LeftLight= '1' Then -- If Trun Left is ON: 
				-- Keep alternating between Addresses 4 and 7 to get Turn Right outputs from ROM
				If (Counter < 4) OR (Counter > 7) Then
					Counter <= 4;
				Else
					Counter <= Counter + 1;
				End if;
			Else
				--Otherwise turn all lights off
				Counter <= 8; -- Address to Turn off the lights
			End if;
		End if;
	End Process;
	--Read from the ROM
	y <= myROM(Counter);
End;

