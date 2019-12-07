Library IEEE;--Including IEEE library.
use IEEE.std_logic_1164.all;-- Including std_logic_1164 package.
Entity problem01 is --Entity declaration.
	Port(w,clk,rst :in std_logic;-- w,Clk,Rst as inputs.
		y: out std_logic);--y as output
End Entity;
Architecture bhv of problem01 is
TYPE State is (A,B,C,D,E);--define enumerated data type for the FSM.
Signal PS:State := A;--declare a signal as FSM type and initialize it.
Begin
	Process(clk,rst)--Define Process which sensetive to Clk and Rst.
	Begin
		if rst='1' Then--If Asychronous Rst is High.
			PS <= A;--go to the initial state A.
		Elsif Clk'event and Clk='0' Then--in the negative edge.
			Case PS is
				when A=>--if the current state is A:
					If w='0' Then
						PS <= A;--Next State is A if w ='0'
					Else
						PS <= B;--Next State is B if w ='1'
					End if;
					
				when B=>--if the current state is B:
					If w='0' Then
						PS <= C;--Next State is C if w ='0'
					Else
						PS <= B;--Next State is B if w ='1'
					End if;
					
				when C=>--if the current state is C:
					If w='0' Then
						PS <= A;--Next State is A if w ='0'
					Else
						PS <= D;--Next State is D if w ='1'
					End if;
					
				when D=>--if the current state is D:
					If w='0' Then
						PS <= C;--Next State is C if w ='0'
					Else
						PS <= E;--Next State is E if w ='1'
					End if;
				when E=>--if the current state is E:
					If w='0' Then
						PS <= C;--Next State is C if w ='0'
					Else
						PS <= B;--Next State is B if w ='1'	
					End if;
			End Case;
		End if;
	End Process;
	Process (PS,w)
	Begin
		if (PS = E and w='0') Then --If FSM's state is in E and output is 0
			y <= '1'; --The output is HIGH
		Else
			y <= '0'; --Otherwise is LOW
		End if;
		
	End Process;
End;