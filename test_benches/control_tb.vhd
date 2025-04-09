-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Sun, 06 Apr 2025 16:09:08 GMT
-- Request id : cfwk-fed377c2-67f2a7241a780

library ieee;
use ieee.std_logic_1164.all;

entity tb_control is
end tb_control;

architecture tb of tb_control is

    component control
        port (clk     : in std_logic;
              bcd_in0 : in std_logic_vector (3 downto 0);
              bcd_in1 : in std_logic_vector (3 downto 0);
              bcd_in2 : in std_logic_vector (3 downto 0);
              bcd_in3 : in std_logic_vector (3 downto 0);
              disp_in : in std_logic_vector (3 downto 0);
              bcd_out : out std_logic_vector (3 downto 0);
              dp      : out std_logic;
              an      : out std_logic_vector (7 downto 0));
    end component;

    signal clk     : std_logic;
    signal bcd_in0 : std_logic_vector (3 downto 0);
    signal bcd_in1 : std_logic_vector (3 downto 0);
    signal bcd_in2 : std_logic_vector (3 downto 0);
    signal bcd_in3 : std_logic_vector (3 downto 0);
    signal disp_in : std_logic_vector (3 downto 0);
    signal bcd_out : std_logic_vector (3 downto 0);
    signal dp      : std_logic;
    signal an      : std_logic_vector (7 downto 0);

    constant TbPeriod : time := 100 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : control
    port map (clk     => clk,
              bcd_in0 => bcd_in0,
              bcd_in1 => bcd_in1,
              bcd_in2 => bcd_in2,
              bcd_in3 => bcd_in3,
              disp_in => disp_in,
              bcd_out => bcd_out,
              dp      => dp,
              an      => an);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        bcd_in0 <= "1111";
        bcd_in1 <= "1000";
        bcd_in2 <= "0001";
        bcd_in3 <= "1001";
        disp_in <= "0100";

        -- ***EDIT*** Add stimuli here
        wait for 100 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_control of tb_control is
    for tb
    end for;
end cfg_tb_control;