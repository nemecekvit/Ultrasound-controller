-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Wed, 02 Apr 2025 18:31:34 GMT
-- Request id : cfwk-fed377c2-67ed8286ca6a2

library ieee;
use ieee.std_logic_1164.all;

entity tb_trig_generator is
end tb_trig_generator;

architecture tb of tb_trig_generator is

    component trig_generator
        generic (
            PULSE_LENGHT : INTEGER := 1500                   
        );
        port (bgn      : in std_logic;
              clk      : in std_logic;
              rst      : in std_logic;
              trig_gen : out std_logic);
    end component;

    signal bgn      : std_logic;
    signal clk      : std_logic;
    signal rst      : std_logic;
    signal trig_gen : std_logic;

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : trig_generator
    generic map (
        PULSE_LENGHT => 1500
    )
    port map (bgn      => bgn,
              clk      => clk,
              rst      => rst,
              trig_gen => trig_gen);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        bgn <= '0';

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        -- ***EDIT*** Add stimuli here
        bgn <= '1';
        wait for 20 ns;
        bgn <= '0';
        wait for 20 ns;

        wait for 2100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_trig_generator of tb_trig_generator is
    for tb
    end for;
end cfg_tb_trig_generator;