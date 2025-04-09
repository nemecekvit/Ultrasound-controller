
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity trig_generator is
    generic (
           PULSE_LENGHT : INTEGER := 1500                   --10uS to start ranging, 100 MHz * 15 uS = 1500  
    );

    Port ( 
        bgn             : in STD_LOGIC;
        clk             : in STD_LOGIC;
        rst             : in STD_LOGIC;
        trig_gen        : out STD_LOGIC
    );
end trig_generator;

architecture Behavioral of trig_generator is
    signal start_flag : std_logic;                          --Flag to start generating trig_gen signal
    signal counter : INTEGER range 0 to PULSE_LENGHT*2;     --Count number of rise edges, maximum 2 times of pulse lenght 
  
begin
    process (clk) is
    begin
        if rising_edge(clk) then
            if bgn = '1' then
                start_flag <= '1';
            end if;
            if rst = '1' then --Reset signal
                trig_gen <= '0';
                start_flag <= '0';
                counter <= 0;

            elsif start_flag = '1' then         --Generation of pulse
                counter <= counter + 1;         --Increment counter
                if counter < PULSE_LENGHT then 
                    trig_gen <= '1';            --Keep trig_gen on high till desired PULSE_LENGHT is achieved
                else                            --Reset signals after desired PULSE_LENGHT is achieved
                    trig_gen <= '0';
                    start_flag <= '0';
                    counter <= 0;
                end if;
            end if;
        end if;
    end process;
end Behavioral;
