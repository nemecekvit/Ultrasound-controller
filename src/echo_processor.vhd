library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity echo_processor is
    Port ( 
        clk             : in STD_LOGIC;
        rst             : in STD_LOGIC;
        echo_in         : in STD_LOGIC;
        data_out        : out STD_LOGIC_VECTOR (11 downto 0)
    );
end echo_processor;

architecture Behavioral of echo_processor is

    signal echo_detected : STD_LOGIC := '0';

    ---1 clock cycle is 10 ns; it take sound +-2941 ns to travel 1 mm
    ---I takes 2941/ 10 = 294 clock cycles to to travel 1mm --> 294 * 2 = 558 clock cycles to trvale 1mm round trip
    constant MILIMETER : INTEGER := 588; 

    signal clock_counter : INTEGER range 0 to MILIMETER +1; --- +1 to avoid overflow problems
    signal milim_counter : INTEGER range 0 to 4001; --Max range of HC - SR04 is 4000 mm, so we use 4001 to avoid overflow problems

begin
    process (clk, rst, echo_in)
    begin
        if echo_in = '1' and echo_detected = '0' then
            echo_detected <= '1';
            clock_counter <= 0; 
            milim_counter <= 0;
        end if;

        if rising_edge(clk) then
            if rst = '1' then
                data_out <= (others => '0');
                echo_detected <= '0';
                clock_counter <= 0; 
                milim_counter <= 0;
            end if; 

            if echo_in = '1' and echo_detected = '1' then      ---echo signal is still active -> count
                if clock_counter = MILIMETER then
                    milim_counter <= milim_counter + 1;
                    clock_counter <= 0;
                else
                    clock_counter <= clock_counter + 1;
                end if;
            elsif echo_in = '0' and echo_detected = '1' then   ---echo signal ended
                echo_detected <= '0';
                data_out <= STD_LOGIC_VECTOR(TO_UNSIGNED(milim_counter, 12)); --- Convert number of milimeter into 12 bit vector
            else
                data_out <= STD_LOGIC_VECTOR(TO_UNSIGNED(milim_counter, 12)); --- Convert number of milimeter into 12 bit vector
            end if;
        end if;
    end process;
end Behavioral;
