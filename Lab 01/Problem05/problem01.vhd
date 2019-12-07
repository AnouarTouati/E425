Library IEEE;--Including IEEE library.
use IEEE.std_logic_1164.all;-- Including std_logic_1164 package.
use ieee.std_logic_unsigned.all;-- Including std_logic_unsigned package.
Entity problem01 is
	Port(clk,rst :in std_logic;--Clk,Rst as inputs.
		dout: out std_logic_vector(6 downto 0));--dout[7] as output.
End Entity;
Architecture bhv of problem01 is
TYPE State is (S01,S02,S03,S04,S05,S06,S07,S08,S09,S10,S11,S12); --define enumerated data type for the FSM.
Signal PS:State := S01;--declare a signal as FSM type and initialize it.
Signal Counter: std_logic_vector(25 downto 0);--define 26 bit counter.
Begin
	Process(clk,rst)--Define Process which sensetive to Clk and Rst.
	Begin
		if rst='1' Then--If Asychronous Rst is High.
			 PS <= S01;--go to the initial state S01.
			 Counter <= (others=>'0');--reset the 26bit counter.
		Elsif Clk'event and Clk='0' Then --in the negative edge.
			Case PS is
				when S01=>--if the current state is S01:
					if Counter=50000000 Then --use clock divider to wait 1s.
						PS <= S02;--Then go to next state.
						Counter <= (others=>'0');--and reset the 26bit counter.
					Else
						Counter <= Counter +1;
					End if;
				when S02=>--if the current state is S02:
					if Counter=25000000 Then --use clock divider to wait 0.5s.
						PS <= S03;--Then go to next state.
						Counter <= (others=>'0');--and reset the 26bit counter.
					Else
						Counter <= Counter +1;
					End if;
				when S03=>--if the current state is S03:
					if Counter=50000000 Then --use clock divider to wait 1s.
						PS <= S04;--Then go to next state.
						Counter <= (others=>'0');--and reset the 26bit counter.
					Else
						Counter <= Counter +1;
					End if;
				when S04=>--if the current state is S03:
					if Counter=25000000 Then--use clock divider to wait 0.5s.
						PS <= S05;--Then go to next state.
						Counter <= (others=>'0');--and reset the 26bit counter.
					Else
						Counter <= Counter +1;
					End if;
				when S05=>
					if Counter=50000000 Then
						PS <= S06;
						Counter <= (others=>'0');
					Else
						Counter <= Counter +1;
					End if;
				when S06=>
					if Counter=25000000 Then
						PS <= S07;
						Counter <= (others=>'0');
					Else
						Counter <= Counter +1;
					End if;
				when S07=>
					if Counter=50000000 Then
						PS <= S08;
						Counter <= (others=>'0');
					Else
						Counter <= Counter +1;
					End if;
				when S08=>
					if Counter=25000000 Then
						PS <= S09;
						Counter <= (others=>'0');
					Else
						Counter <= Counter +1;
					End if;
				when S09=>
					if Counter=50000000 Then
						PS <= S10;
						Counter <= (others=>'0');
					Else
						Counter <= Counter +1;
					End if;
				when S10=>
					if Counter=25000000 Then
						PS <= S11;
						Counter <= (others=>'0');
					Else
						Counter <= Counter +1;
					End if;
				when S11=>
					if Counter=50000000 Then
						PS <= S12;
						Counter <= (others=>'0');
					Else
						Counter <= Counter +1;
					End if;
				when S12=>--if the current state is S03:
					if Counter=25000000 Then--use clock divider to wait 0.5s.
						PS <= S01;--Then go to next state.
						Counter <= (others=>'0');--and reset the 26bit counter.
					Else
						Counter <= Counter +1;
					End if;
				
				
			End Case;
		End if;
	End Process;
	--Output the desired output depending on the state:
	dout <= "1011111" When PS=S01 Else
			"1001111" When PS=S02 Else
			"1101111" When PS=S03 Else
			"1100111" When PS=S04 Else
			"1110111" When PS=S05 Else
			"1110011" When PS=S06 Else
			"1111011" When PS=S07 Else
			"1111001" When PS=S08 Else
			"1111101" When PS=S09 Else
			"1111100" When PS=S10 Else
			"1111110" When PS=S11 Else
			"1011110";
	
End;