-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Sun, 06 Apr 2025 17:50:08 GMT
-- Request id : cfwk-fed377c2-67f2bed0291f5

library ieee;
use ieee.std_logic_1164.all;

entity tb_bin2bcd is
end tb_bin2bcd;

architecture tb of tb_bin2bcd is

    component bin2bcd
        port (clk       : in std_logic;
              rst       : in std_logic;
              binary_in : in std_logic_vector (11 downto 0);
              bcd_out0  : out std_logic_vector (3 downto 0);
              bcd_out1  : out std_logic_vector (3 downto 0);
              bcd_out2  : out std_logic_vector (3 downto 0);
              bcd_out3  : out std_logic_vector (3 downto 0));
    end component;

    signal clk       : std_logic;
    signal rst       : std_logic;
    signal binary_in : std_logic_vector (11 downto 0);
    signal bcd_out0  : std_logic_vector (3 downto 0);
    signal bcd_out1  : std_logic_vector (3 downto 0);
    signal bcd_out2  : std_logic_vector (3 downto 0);
    signal bcd_out3  : std_logic_vector (3 downto 0);

    constant TbPeriod : time := 10 ns; -- ***EDIT*** Put right period here
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : bin2bcd
    port map (clk       => clk,
              rst       => rst,
              binary_in => binary_in,
              bcd_out0  => bcd_out0,
              bcd_out1  => bcd_out1,
              bcd_out2  => bcd_out2,
              bcd_out3  => bcd_out3);

    -- Clock generation
    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    -- ***EDIT*** Check that clk is really your main clock signal
    clk <= TbClock;

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        binary_in <= (others => '0');

        -- Reset generation
        -- ***EDIT*** Check that rst is really your reset signal
        rst <= '1';
        wait for 100 ns;
        rst <= '0';
        wait for 100 ns;

        -- ***EDIT*** Add stimuli here
        binary_in <= "111111111111";
        wait for 20 * TbPeriod;
        
        binary_in <= "101010101010";
        wait for 20 * TbPeriod;
        
        binary_in <= "010101010101";
        wait for 20 * TbPeriod;
        
        binary_in <= "000000000111";
        wait for 20 * TbPeriod;

        -- Stop the clock and hence terminate the simulation
        TbSimEnded <= '1';
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_bin2bcd of tb_bin2bcd is
    for tb
    end for;
end cfg_tb_bin2bcd;