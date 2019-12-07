Library IEEE; --Including IEEE library.
use IEEE.std_logic_1164.all; -- Including std_logic_1164 package.
Entity problem01 is --Entity declaration.
	Port(w,clk,rst :in std_logic;-- w,Clk,Rst as inputs.
		y: out std_logic);--y as output
End Entity;
Architecture bhv of problem01 is
TYPE State is (A,B,C,D,E,F);--define enumerated data type for the FSM.
Signal PS:State := A;--declare a signal as FSM type and initialize it.
Begin
	Process(clk,rst)--Define Process which sensetive to Clk and Rst.
	Begin
		if rst='1' Then--if Asychronous Rst is High.
			PS <= A;--go to the initial state A.
		Elsif Clk'event and Clk='0' Then--in the negative edge.
			Case PS is
				when A=>--if the current state is A:
					if w='0' Then
						PS <= B;--Next State is B if w ='0'
					Else
						PS <= A;--Next State is A if w ='1'
					End if;
				when B=>--if the current state is B:
					if w='0' Then
						PS <= C;--Next State is C if w ='0'
					Else
						PS <= A;--Next State is A if w ='1'
					End if;
				when C=>--if the current state is C:
					if w='0' Then
						PS <= C;--Next State is C if w ='0'
					Else
						PS <= D;--Next State is D if w ='1'
					End if;
				when D=>--if the current state is D:
					if w='0' Then
						PS <= E;--Next State is E if w ='0'
					Else
						PS <= A;--Next State is A if w ='1'
					End if;
				when E=>--if the current state is E:
					if w='0' Then
						PS <= C;--Next State is C if w ='0'
					Else
						PS <= F;--Next State is F if w ='1'
					End if;
				when F=>--if the current state is F:
					if w='0' Then
						PS <= B;--Next State is B if w ='0'
					Else
						PS <= A;--Next State is A if w ='1'
					End if;
				
			End Case;
		End if;
	End Process;
	y <= '1' When PS =F Else -- w output is HIGH whenever we are in state F
		'0';--otherwise w = LOW
End;