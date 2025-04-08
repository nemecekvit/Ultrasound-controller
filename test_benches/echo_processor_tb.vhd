-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Mon, 07 Apr 2025 08:04:21 GMT
-- Request id : cfwk-fed377c2-67f38705dcecb

library ieee;
use ieee.std_logic_1164.all;

entity tb_echo_processor is
end tb_echo_processor;

architecture tb of tb_echo_processor is

    component echo_processor
        port (clk      : in std_logic;
              rst      : in std_logic;
              echo_in  : in std_logic;
              data_out : out std_logic_vector (11 downto 0));
    end component;

    signal clk      : std_logic;
    signal rst      : std_logic;
    signal echo_in  : std_logic;
    signal data_out : std_logic_vector (11 downto 0);

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : echo_processor
    port map (clk      => clk,
              rst      => rst,
              echo_in  => echo_in,
              data_out => data_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        echo_in <= '0';

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        -- ***EDIT*** Add stimuli here
        echo_in <= '1';
        --wait for 1_178_000 * TbPeriod * 2;
        wait for 1_481_760 * TbPeriod;
        echo_in <= '0';


        wait for 1000 * TbPeriod;

        echo_in <= '1';
        --wait for 1_178_000 * TbPeriod * 2;
        wait for 500_000* TbPeriod;
        echo_in <= '0';

        wait for 1000 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_echo_processor of tb_echo_processor is
    for tb
    end for;
end cfg_tb_echo_processor;