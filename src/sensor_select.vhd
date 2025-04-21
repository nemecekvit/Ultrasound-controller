
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity sensor_select is
    Port ( sens_in_1  : in STD_LOGIC_VECTOR(11 downto 0);
           sens_in_2  : in STD_LOGIC_VECTOR(11 downto 0);
           sens_in_3  : in STD_LOGIC_VECTOR(11 downto 0);
           sens_in_4  : in STD_LOGIC_VECTOR(11 downto 0);
           select_in  : in STD_LOGIC_VECTOR(3 downto 0);
           avg_in     : in STD_LOGIC;
           data_out   : out STD_LOGIC_VECTOR(11 downto 0);
           select_out : out STD_LOGIC_VECTOR(3 downto 0)
    );
end sensor_select;

architecture Behavioral of sensor_select is

    signal sig_avg : STD_LOGIC_VECTOR(47 downto 0);
    signal avg_out : STD_LOGIC_VECTOR(13 downto 0);

begin

    process (select_in, sens_in_1, sens_in_2, sens_in_3, sens_in_4) is
    begin
        if avg_in = '0' then
            
            select_out <= select_in;

            case select_in is
                when "0001" =>
                    data_out <= sens_in_1;
                      
                when "0010" =>
                    data_out <= sens_in_2;
                
                when "0100" =>
                    data_out <= sens_in_3;
                
                when "1000" =>
                    data_out <= sens_in_4;            
    
                when others =>
                    select_out <= (others => '0');
                    data_out <= (others => '0');
            end case;
        else     

            sig_avg <= b"000_000_000_000" & sig_avg(47 downto 12);
            select_out <= select_in;

            case select_in is
                when "0001" =>        
                    sig_avg(47 downto 36) <= sens_in_1;
                      
                when "0010" =>
                    sig_avg(47 downto 36) <= sens_in_2;
                
                when "0100" =>
                    sig_avg(47 downto 36) <= sens_in_3;
                
                when "1000" =>
                    sig_avg(47 downto 36) <= sens_in_4;        
    
                when others =>
                    select_out <= (others => '0');
                    sig_avg <= (others => '0');
                    data_out <= (others => '0');
            end case;

            avg_out <= sig_avg(47 downto 36) + sig_avg(35 downto 24) + sig_avg(23 downto 12) + sig_avg(11 downto 0);
            avg_out <= b"00" & avg_out(13 downto 2);
            data_out <= avg_out(11 downto 0);

        end if;        
    end process;

end Behavioral;
