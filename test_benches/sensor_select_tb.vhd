-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : Mon, 21 Apr 2025 13:54:11 GMT
-- Request id : cfwk-fed377c2-68064e032b49a

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
              avg_in     : in std_logic;
              data_out   : out std_logic_vector (11 downto 0);
              select_out : out std_logic_vector (3 downto 0));
    end component;

    signal sens_in_1  : std_logic_vector (11 downto 0);
    signal sens_in_2  : std_logic_vector (11 downto 0);
    signal sens_in_3  : std_logic_vector (11 downto 0);
    signal sens_in_4  : std_logic_vector (11 downto 0);
    signal select_in  : std_logic_vector (3 downto 0);
    signal avg_in     : std_logic;
    signal data_out   : std_logic_vector (11 downto 0);
    signal select_out : std_logic_vector (3 downto 0);

begin

    dut : sensor_select
    port map (sens_in_1  => sens_in_1,
              sens_in_2  => sens_in_2,
              sens_in_3  => sens_in_3,
              sens_in_4  => sens_in_4,
              select_in  => select_in,
              avg_in     => avg_in,
              data_out   => data_out,
              select_out => select_out);

    stimuli : process
    begin
        -- ***EDIT*** Adapt initialization as needed
        sens_in_1 <= (others => '0');
        sens_in_2 <= (others => '0');
        sens_in_3 <= (others => '0');
        sens_in_4 <= (others => '0');
        select_in <= (others => '0');
        avg_in <= '0';

        -- ***EDIT*** Add stimuli here

        wait for 10 ns;
        avg_in <= '1';
        select_in <= "0001";

        wait for 10 ns;
        sens_in_1 <= x"001";

        wait for 10 ns;
        sens_in_1 <= x"003";

        wait for 10 ns;
        sens_in_1 <= x"001";

        wait for 10 ns;
        sens_in_1 <= x"003";

        wait for 10 ns;
        sens_in_1 <= x"002";

        wait for 10 ns;





        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_sensor_select of tb_sensor_select is
    for tb
    end for;
end cfg_tb_sensor_select;