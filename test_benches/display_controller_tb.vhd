
library ieee;
use ieee.std_logic_1164.all;

entity tb_display_controller is
end tb_display_controller;

architecture tb of tb_display_controller is

    component display_controller
        port (CLK100MHZ : in std_logic;
              rst       : in std_logic;
              data_in   : in std_logic_vector (11 downto 0);
              select_in : in std_logic_vector (3 downto 0);
              seg       : out std_logic_vector (6 downto 0);
              DP        : out std_logic;
              AN        : out std_logic_vector (7 downto 0));
    end component;

    signal CLK100MHZ : std_logic;
    signal rst       : std_logic;
    signal data_in   : std_logic_vector (11 downto 0);
    signal select_in : std_logic_vector (3 downto 0);
    signal seg       : std_logic_vector (6 downto 0);
    signal DP        : std_logic;
    signal AN        : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : display_controller
    port map (CLK100MHZ => CLK100MHZ,
              rst       => rst,
              data_in   => data_in,
              select_in => select_in,
              seg       => seg,
              DP        => DP,
              AN        => AN);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that CLK100MHZ is really your main clock signal
    CLK100MHZ <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        data_in <= (others => '0');
        select_in <= (others => '0');

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        data_in <= "101010101010";
        select_in <= "1000";
        wait for 5 * TbPeriod;
        
        data_in <= "010101010101";
        select_in <= "0100";
        wait for 5 * TbPeriod;
        
        data_in <= "000000000000";
        select_in <= "0010";
        wait for 5 * TbPeriod;
        
        data_in <= "111111111111";
        select_in <= "0001";
        wait for 5 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_display_controller of tb_display_controller is
    for tb
    end for;
end cfg_tb_display_controller;