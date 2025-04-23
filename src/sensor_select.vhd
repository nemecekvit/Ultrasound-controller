library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sensor_select is
    Port ( sens_in_1  : in STD_LOGIC_VECTOR(11 downto 0);
           sens_in_2  : in STD_LOGIC_VECTOR(11 downto 0);
           sens_in_3  : in STD_LOGIC_VECTOR(11 downto 0);
           sens_in_4  : in STD_LOGIC_VECTOR(11 downto 0);
           select_in  : in STD_LOGIC_VECTOR(3 downto 0);
           data_out   : out STD_LOGIC_VECTOR(11 downto 0);
           select_out : out STD_LOGIC_VECTOR(3 downto 0)
    );
end sensor_select;

architecture Behavioral of sensor_select is
begin

    process (select_in) is
    begin
        case select_in is
            when "0001" =>
                select_out <= select_in;
                data_out <= sens_in_1;
                  
            when "0010" =>
                select_out <= select_in;
                data_out <= sens_in_2;
            
            when "0100" =>
                select_out <= select_in;
                data_out <= sens_in_3;
            
            when "1000" =>
                select_out <= select_in;
                data_out <= sens_in_4;            

            when others =>
                select_out <= (others => '0');
                data_out <= (others => '0');
        end case;
    end process;

end Behavioral;