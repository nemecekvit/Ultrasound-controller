-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Sat, 05 Apr 2025 15:21:34 GMT
-- Request id : cfwk-fed377c2-67f14a7ecff9d

library ieee;
use ieee.std_logic_1164.all;

entity tb_sensor_driver is
end tb_sensor_driver;

architecture tb of tb_sensor_driver is

    component sensor_driver
        generic (
            TRIG_SIG_LEN        : INTEGER := 1500;
            TRIG_SIG_PERIDOD    : INTEGER := 7_500_000                   
        );
        port (clk      : in std_logic;
              rst      : in std_logic;
              echo     : in std_logic;
              trig     : out std_logic;
              sens_out : out std_logic_vector (11 downto 0));
    end component;

    signal clk      : std_logic;
    signal rst      : std_logic;
    signal echo     : std_logic;
    signal trig     : std_logic;
    signal sens_out : std_logic_vector (11 downto 0);

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : sensor_driver
    generic map (
        TRIG_SIG_LEN    => 1500,
        TRIG_SIG_PERIDOD  => 2000  --7_500_000
    )
    port map (clk      => clk,
              rst      => rst,
              echo     => echo,
              trig     => trig,
              sens_out => sens_out);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        echo <= '0';

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        -- ***EDIT*** Add stimuli here
        echo <= '1';
        wait for 1_178_000 * TbPeriod * 2;
        echo <= '0';
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_sensor_driver of tb_sensor_driver is
    for tb
    end for;
end cfg_tb_sensor_driver;