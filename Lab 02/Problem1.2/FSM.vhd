library IEEE;--Including IEEE library.
use ieee.std_logic_1164.all;-- Including std_logic_1164 package.

Entity FSM is--Entity declaration.
	Port(rst,clk:in std_logic;-- Clk,Rst as inputs.
		IntIn:in integer;-- 32bit input as intger.
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
					if IntIn=1 Then--if input integer is 1.
						PS <= B;--go to next state.
					Else--Otherwise go back to state A.
						PS <= A;
					End if;
				When B=>--if the current state is B:
					if  IntIn=2 Then--if input integer is 2.
						PS <= C;--go to next state.
					Else--Otherwise go back to state A.
						PS <= A;
					End if;
				When C=>--if the current state is C:
					if  IntIn=3 Then--if input integer is 3.
						PS <= D;--go to next state.
					Else--Otherwise go back to state A.
						PS <= A;
					End if;
				When D=>--if the current state is D:
					if  IntIn=4 Then--if input integer is 4.
						PS <= E;--go to next state.
					Else--Otherwise go back to state A.
						PS <= A;
					End if;
				When E=>--if the current state is E:
					if  IntIn=5 Then--if input integer is 5.
						PS <= F;--go to next state.
					Else--Otherwise go back to state A.
						PS <= A;
					End if;
				When F=>--if the current state is F:
					PS <= A;--go back to state A.
			End Case;
		End If;
	End Process;
	y <= '1' when PS=F else--output is HIGH only if state F is reached
		'0';
End;

