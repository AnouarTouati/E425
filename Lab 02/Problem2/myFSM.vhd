Library IEEE;--Including IEEE library.
use IEEE.std_logic_1164.all;-- Including std_logic_1164 package.

Entity myFSM is
	Port(Nickle5_in,Dime10_in,Quarter25_in,Rst,clk:in std_logic;--inputs
		Nickle5_out,Dime10_out,Candy_out:out std_logic);--outputs
End Entity;

Architecture fsm of myFSM is
TYPE State is (S00,S05,S10,S15,S20,S25,S30,S35,S40,S45);--define enumerated data type for the FSM.
signal PS:State := S00;--declare a signal as FSM type and initialize it.
Begin
	Process (clk,Rst) is--Define Process which sensetive to Clk and Rst.
	Begin
		if Rst='1' Then --if Asychronous Rst is High.
			PS <= S00;--go to the initial state A.
		Elsif Clk'event and Clk='0' Then--in the positive edge.
			Case PS is
				When S00 =>--if there is no money inserted.
					If  Nickle5_in = '1' Then -- 5 centes is added.
						PS<=S05;
					Elsif Dime10_in = '1' Then-- 10 centes is added.
						PS<=S10;
					Elsif Quarter25_in = '1' Then-- 25 centes is added.
						PS<=S25;
					End if;
				When S05 =>-- if 5 cents has been inserted.
					If  Nickle5_in = '1' Then  -- 5 centes is added.
						PS<=S10;
					Elsif Dime10_in = '1' Then -- 10 centes is added.
						PS<=S15;
					Elsif Quarter25_in = '1' Then -- 25 centes is added.
						PS<=S30;
					End if;
				When S10 =>-- if 10 cents has been inserted.
					If  Nickle5_in = '1' Then 
						PS<=S15;
					Elsif Dime10_in = '1' Then
						PS<=S20;
					Elsif Quarter25_in = '1' Then
						PS<=S35;
					End if;
				When S15 =>-- if 15 cents has been inserted.
					If  Nickle5_in = '1' Then 
						PS<=S20;
					Elsif Dime10_in = '1' Then
						PS<=S25;
					Elsif Quarter25_in = '1' Then
						PS<=S40;
					End if;
				When S20 =>-- if 20 cents has been inserted.
					If  Nickle5_in = '1' Then 
						PS<=S25;
					Elsif Dime10_in = '1' Then
						PS<=S30;
					Elsif Quarter25_in = '1' Then
						PS<=S45;
					End if;
				When S25 =>-- if 25 cents has been inserted.
					--You should not enter any more money here
					PS<=S00;--Go back to first state (S00).
				When S30 =>-- if 30 cents has been inserted.
					--You should not enter any more money here
					PS<=S25;--Go to state S25.
				When S35 =>-- if 35 cents has been inserted.
					--You should not enter any more money here
					PS<=S25;--Go to state S25.
				When S40 =>-- if 40 cents has been inserted.
					--You should not enter any more money here
					PS<=S35;--Go to state S35.
				When S45 =>-- if 45 cents has been inserted.
					--You should not enter any more money here
					PS<=S35;--Go to state S45.
			End Case;
		End if;
	End Process;
	Process (PS) is
	Begin
	--Nickle5_out,Dime10_out,Candy_out
		Case PS is
			When S25 =>
			
				Nickle5_out<= '0';
				Dime10_out <= '0';
				Candy_out  <= '1';
			When S30 =>
				Nickle5_out<= '1';
				Dime10_out <= '0';
				Candy_out  <= '0';
			When S35 =>
				Nickle5_out<= '0';
				Dime10_out <= '1';
				Candy_out  <= '0';
			When S40 =>
				Nickle5_out<= '1';
				Dime10_out <= '0';
				Candy_out  <= '0';
			When S45 =>
				Nickle5_out<= '0';
				Dime10_out <= '1';
				Candy_out  <= '0';
			When Others =>
				Nickle5_out<= '0';
				Dime10_out <= '0';
				Candy_out  <= '0';
		End Case;
	End Process;
End;

