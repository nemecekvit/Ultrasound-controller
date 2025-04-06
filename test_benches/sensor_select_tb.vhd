-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Sat, 05 Apr 2025 14:12:39 GMT
-- Request id : cfwk-fed377c2-67f13a576e7db

library ieee;
use ieee.std_logic_1164.all;

entity tb_sensor_select is
end tb_sensor_select;

architecture tb of tb_sensor_select is

    component sensor_select
        port (sens_in_1  : in std_logic_vector (11 downto 0);
              sens_in_2  : in std_logic_vector (11 downto 0);
              sens_in_3  : in std_logic_vector (11 downto 0);
              sens_in_4  : in std_logic_vector (11 downto 0);
              select_in  : in std_logic_vector (3 downto 0);
              data_out   : out std_logic_vector (11 downto 0);
              select_out : out std_logic_vector (3 downto 0));
    end component;

    signal sens_in_1  : std_logic_vector (11 downto 0);
    signal sens_in_2  : std_logic_vector (11 downto 0);
    signal sens_in_3  : std_logic_vector (11 downto 0);
    signal sens_in_4  : std_logic_vector (11 downto 0);
    signal select_in  : std_logic_vector (3 downto 0);
    signal data_out   : std_logic_vector (11 downto 0);
    signal select_out : std_logic_vector (3 downto 0);

begin

    dut : sensor_select
    port map (sens_in_1  => sens_in_1,
              sens_in_2  => sens_in_2,
              sens_in_3  => sens_in_3,
              sens_in_4  => sens_in_4,
              select_in  => select_in,
              data_out   => data_out,
              select_out => select_out);

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        sens_in_1 <= x"001";
        sens_in_2 <= x"002";
        sens_in_3 <= x"003";
        sens_in_4 <= x"004";
        select_in <= "0000";

        -- ***EDIT*** Add stimuli here

        wait for 10 ns;
        select_in <= "0001";

        wait for 10 ns;
        select_in <= "0010";

        wait for 10 ns;
        select_in <= "0100";

        wait for 10 ns;
        select_in <= "1000";

        wait for 10 ns;
        select_in <= "0011";

        wait for 10 ns;

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_sensor_select of tb_sensor_select is
    for tb
    end for;
end cfg_tb_sensor_select;