library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity control is
    Port (
        clk      : in  std_logic;
        bcd_in0  : in  std_logic_vector (3 downto 0);
        bcd_in1  : in  std_logic_vector (3 downto 0);
        bcd_in2  : in  std_logic_vector (3 downto 0);
        bcd_in3  : in  std_logic_vector (3 downto 0);
        disp_in  : in  std_logic_vector (3 downto 0);
        bcd_out  : out std_logic_vector (3 downto 0);
        dp       : out std_logic;
        an       : out std_logic_vector (7 downto 0)
    );
end control;

architecture Behavioral of control is

    signal choose : natural range 0 to 4 := 0;

begin

    process(clk)
    begin
        if rising_edge(clk) then
            dp <= '0';  -- Default value
            case choose is
                when 0 =>
                    bcd_out <= bcd_in0;
                    an <= "11111110";
                when 1 =>
                    bcd_out <= bcd_in1;
                    an <= "11111101";
                when 2 =>
                    bcd_out <= bcd_in2;
                    an <= "11111011";
                when 3 =>
                    bcd_out <= bcd_in3;
                    an <= "11110111";
                    dp <= '1';
                when 4 =>
                    case disp_in is
                        when "1000" => bcd_out <= "0001";
                        when "0100" => bcd_out <= "0010";
                        when "0010" => bcd_out <= "0011";
                        when "0001" => bcd_out <= "0100";
                        when others => bcd_out <= "0000";
                    end case;
                    an <= "01111111";
            end case;

            -- Cycle choose from 0 to 4
            if choose = 4 then
                choose <= 0;
            else
                choose <= choose + 1;
            end if;
        end if;
    end process;

end Behavioral;