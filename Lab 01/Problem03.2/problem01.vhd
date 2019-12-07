Library IEEE;
use IEEE.std_logic_1164.all;
Entity problem01 is
	Port(w,clk,rst :in std_logic;
		y: out std_logic);
End Entity;
Architecture bhv of problem01 is
TYPE State is (A,B,C,D);
Signal PS1:State := A;
Signal PS2:State := A;
Begin
	Process(clk,rst)
	Begin
		if rst='1' Then
			PS1 <= A;
		Elsif Clk'event and Clk='0' Then
			Case PS1 is
				when A=>
					if w='0' Then
						PS1 <= A;
					Else
						PS1 <= B;
					End if;
				when B=>
					if w='0' Then
						PS1 <= C;
					Else
						PS1 <= B;
					End if;
				when C=>
					if w='0' Then
						PS1 <= D;
					Else
						PS1 <= B;
					End if;
				when D=>
					if w='0' Then
						PS1 <= D;
					Else
						PS1 <= D;
					End if;
				
			End Case;
		End if;
	End Process;
	Process(PS1,clk,rst)
	Begin
		if rst='1' Then
			PS2 <= A;
		Elsif PS1 = D Then
			PS2 <= A;
		Elsif Clk'event and Clk='0' Then
			Case PS2 is
				when A=>
					if w='0' Then
						PS2 <= B;
					Else
						PS2 <= A;
					End if;
				when B=>
					if w='0' Then
						PS2 <= B;
					Else
						PS2 <= C;
					End if;
				when C=>
					if w='0' Then
						PS2 <= D;
					Else
						PS2 <= A;
					End if;
				when D=>
					if w='0' Then
						PS2 <= B;
					Else
						PS2 <= C;
					End if;
				
			End Case;
		End if;
	End Process;
	y <= '1' When PS2 =D Else
		'0';
End;