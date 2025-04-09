-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 26.2.2025 13:35:40 UTC

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_bin2seg is
end tb_bin2seg;

architecture tb of tb_bin2seg is

    component bin2seg
        port (clear : in std_logic;
              bin   : in std_logic_vector (3 downto 0);
              seg   : out std_logic_vector (6 downto 0));
    end component;

    signal clear : std_logic;
    signal bin   : std_logic_vector (3 downto 0);
    signal seg   : std_logic_vector (6 downto 0);

begin

    dut : bin2seg
    port map (clear => clear,
              bin   => bin,
              seg   => seg);

    stimuli : process
    begin
        report "=== START ===";
        clear <= '0';
        bin <= (others => '0');
        wait for 50ns;
        
        clear <= '1';
        wait for 50ns;
        assert seg = "1111111"
            report "CHYBA Clear" severity error;
        
        clear <= '0';
        for i in 0to 15 loop
            bin <= std_logic_vector(to_unsigned(i, 4));
            wait for 50ns;
        end loop;
        
        report "=== KONEC ===";
        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_bin2seg of tb_bin2seg is
    for tb
    end for;
end cfg_tb_bin2seg;