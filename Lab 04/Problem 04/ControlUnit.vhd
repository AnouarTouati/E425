Library IEEE;
use IEEE.std_logic_1164.all;
Entity ControlUnit is
	Port(clk,rst :in std_logic;-- Clk and Reset for the whole the system.
		DataOut:out std_logic_vector(7 downto 0);-- DataOut of the RAM (for debuging purposes).
		osrROM,osrRAM,oswRAM : out std_logic;--Internal outputs of the FSM (for debuging purposes).
		oAddressBus : out integer range 0 to 3;--Internal Address Bus (for debuging purposes).
		oDataBus : out std_logic_vector(7 downto 0));--Internal Data Bus (for debuging purposes).
End Entity;

Architecture bhv of ControlUnit is
	--Declaration of RAM component.
	component RAM is
		Port(clk,RD,WE :in std_logic;
			Address:in Integer range 0 to 3;
			DataIn:in std_logic_vector(7 downto 0);
			DataOut:out std_logic_vector(7 downto 0));
	End Component;
	--Declaration of ROM component.
	component ROM is
		Port(clk,RD :in std_logic;
			Address:in Integer range 0 to 3;
			DataOut:out std_logic_vector(7 downto 0));
	End Component;
	--Declaration of FSM component.
	component FSM is
		Port(clk,rst :in std_logic;
			rROM,rRAM,wRAM : out std_logic;
			Address:out integer range 0 to 3);
	End Component;
	--Internal signals between components.
	signal srROM,srRAM,swRAM : std_logic;
	signal AddressBus : integer range 0 to 3;
	signal DataBus : std_logic_vector(7 downto 0);
Begin
	F1:FSM port map(clk,rst,srROM,srRAM,swRAM,AddressBus);--Maping the signlas of the FSM.
	F2:ROM port map(clk,srROM,AddressBus,DataBus);--Maping the signlas of the ROM.
	F3:RAM port map(clk,srRAM,swRAM,AddressBus,DataBus,DataOut);--Maping the signlas of the ROM.
	osrROM <= srROM;--Assigning the srROM internal signal to the output (for debuging).
	osrRAM <= srRAM;--Assigning the srRAM internal signal to the output (for debuging).
	oswRAM <= srRAM;--Assigning the srRAM internal signal to the output (for debuging).
	oAddressBus <= AddressBus;--Assigning the AddressBus internal signal to the output (for debuging).
	oDataBus <= DataBus;--Assigning the DataBus internal signal to the output (for debuging).
End;
