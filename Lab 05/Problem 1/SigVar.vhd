Library IEEE;
use IEEE.std_logic_1164.all;

Entity SigVar is
	Port(
		clk,rst:in std_logic;
		A_out,B_out:out integer );
End Entity;

Architecture bhv of SigVar is
	signal sig_1:integer := 1;
	signal sig_2:integer := 2;
	signal sig_3:integer := 3;
	Begin			
		Process (clk) is
			variable var_1:integer := 1;
			variable var_2:integer := 2;
			variable var_3:integer := 3;
		Begin
			If rst='1' Then
				A_out <= 0;
				B_out <= 0;
			Elsif (clk'event and clk='1') Then
				var_1 :=var_2+var_3;
				var_2 :=var_1;
				var_3 :=var_2;
				B_out <= var_1 + var_2 + var_3;
				-- B_out <= ( var_2 + var_3 )*3
				-- var_1+ = var_2+ = var_3+ = 2*B_out
				sig_1 <= sig_2 + sig_3;
				sig_2 <= sig_1;
				sig_3 <= sig_2;
				A_out <= sig_1 + sig_2 + sig_3;
				-- A_out <= ( sig_1 + sig_2 + sig_3)
			End If;
		End Process;
End;
