library IEEE;--Including IEEE library.
use ieee.std_logic_1164.all;-- Including std_logic_1164 package.

Entity FSM is--Entity declaration.
	Port(rst,clk:in std_logic;-- Clk,Rst as inputs.
		Charin:in character;-- 8bit input as charachter with ASCI code
		y:out std_logic);--y as output
End Entity;
Architecture myfsm of FSM is

TYPE State is (A,B,C,D,E,F);--define enumerated data type for the FSM.
signal PS:State := A;--declare a signal as FSM type and initialize it.
Begin
	Process(clk,rst) is--Define Process which sensetive to Clk and Rst.
	Begin
		if Rst = '1' Then--if Asychronous Rst is High.
			PS <= A;--go to the initial state A.
		Elsif Clk'event and Clk = '1' Then--in the positive edge.
			Case PS is
				When A=>--if the current state is A:
					if Charin='M' Then--if input charachter is "M"
						PS <= B;--go to next state.
					Else--Otherwise go back to state A.
						PS <= A;
					End if;
				When B=>--if the current state is B:
					if  Charin='a' Then--if input charachter is "a".
						PS <= C;--go to next state.
					Else
						PS <= A;--Otherwise go back to state A.
					End if;
				When C=>
					if  Charin='l' Then --if input charachter is "l".
						PS <= D;--go to next state.
					Else
						PS <= A;--Otherwise go back to state A.
					End if;
				When D=>
					if  Charin='i' Then--if input charachter is "i".
						PS <= E;--go to next state.
					Else
						PS <= A;--Otherwise go back to state A.
					End if;
				When E=>
					if  Charin='k' Then--if input charachter is "k".
						PS <= F;--Otherwise go back to state A for new sequence.
					Else
						PS <= A;--Otherwise go back to state A.
					End if;
				When F=>
					PS <= A;--Otherwise go back to state A for new sequence.			
			End Case;
		End If;
	End Process;
	y <= '1' when PS=F else--output is HIGH only if state F is reached
		'0';
End;

