Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
Entity FSM is
	Port(clk,rst :in std_logic;
		rROM,rRAM,wRAM : out std_logic;
		Address:out integer range 0 to 3);
End Entity;

Architecture bhv of FSM is
Type FSMType is (S1,S2,S3,S4,S5,S6,S7,S8,S9);
signal PS : FSMType := S1;
Begin
	Process (clk,rst) is
	Begin
		if rst = '0' Then
			PS <= S1;
		Elsif clk'event and clk = '0' Then
			case PS is
				when S1 =>
					PS <= S2;
				when S2 =>
					PS <= S3;
				when S3 =>
					PS <= S4;
				when S4 =>
					PS <= S5;
				when S5 =>
					PS <= S6;
				when S6 =>
					PS <= S7;
				when S7 =>
					PS <= S8;
				when S8 =>
					PS <= S8;
				when S9 =>
					PS <= S1;
			End Case;
		End if;
	End Process;
	Process (PS)
	Begin
		case PS is
			when S1 =>
				Address <= 0;
				rROM <= '1';
				wRAM <= '1';
				rRAM <= '0';
			when S2 =>
				Address <= 1;
				rROM <= '1';
				wRAM <= '1';
				rRAM <= '0';
			when S3 =>
				Address <= 2;
				rROM <= '1';
				wRAM <= '1';
				rRAM <= '0';
			when S4 =>
				Address <= 3;
				rROM <= '1';
				wRAM <= '1';
				rRAM <= '0';
			when S5 =>
				Address <= 0;
				rROM <= '0';
				wRAM <= '0';
				rRAM <= '1';
			when S6 =>
				Address <= 1;
				rROM <= '0';
				wRAM <= '0';
				rRAM <= '1';
			when S7 =>
				Address <= 2;
				rROM <= '0';
				wRAM <= '0';
				rRAM <= '1';
			when S8 =>
				Address <= 3;
				rROM <= '0';
				wRAM <= '0';
				rRAM <= '1';
			when S9 =>
				Address <= 0;
				rROM <= '0';
				wRAM <= '0';
				rRAM <= '0';
		End Case;
	End Process;
End;
