library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bin2bcd is
    Port (
        clk       : in  std_logic;
        rst       : in  std_logic;
        binary_in : in  std_logic_vector(11 downto 0);  
        bcd_out0  : out std_logic_vector(3 downto 0);
        bcd_out1  : out std_logic_vector(3 downto 0);
        bcd_out2  : out std_logic_vector(3 downto 0);
        bcd_out3  : out std_logic_vector(3 downto 0)   
    );
end bin2bcd;

architecture Behavioral of bin2bcd is
begin

    process(clk, rst)
        variable temp_bcd : std_logic_vector(27 downto 0);
        variable bin      : std_logic_vector(11 downto 0);
    begin
        if rst = '1' then
            bcd_out0 <= (others => '0');
            bcd_out1 <= (others => '0');
            bcd_out2 <= (others => '0');
            bcd_out3 <= (others => '0');
            temp_bcd := (others => '0'); 
        elsif rising_edge(clk) then
            bin := binary_in;
            temp_bcd := (others => '0'); 
            temp_bcd(11 downto 0) := bin;

            for i in 0 to 11 loop
                if unsigned(temp_bcd(27 downto 24)) > 4 then
                    temp_bcd(27 downto 24) := std_logic_vector(unsigned(temp_bcd(27 downto 24)) + 3);
                end if;
                if unsigned(temp_bcd(23 downto 20)) > 4 then
                    temp_bcd(23 downto 20) := std_logic_vector(unsigned(temp_bcd(23 downto 20)) + 3);
                end if;
                if unsigned(temp_bcd(19 downto 16)) > 4 then
                    temp_bcd(19 downto 16) := std_logic_vector(unsigned(temp_bcd(19 downto 16)) + 3);
                end if;
                if unsigned(temp_bcd(15 downto 12)) > 4 then
                    temp_bcd(15 downto 12) := std_logic_vector(unsigned(temp_bcd(15 downto 12)) + 3);
                end if;

                temp_bcd := temp_bcd(26 downto 0) & '0';
            end loop;

            bcd_out3 <= temp_bcd(27 downto 24);
            bcd_out2 <= temp_bcd(23 downto 20);
            bcd_out1 <= temp_bcd(19 downto 16);
            bcd_out0 <= temp_bcd(15 downto 12);  
        end if;
    end process;
    
end Behavioral;