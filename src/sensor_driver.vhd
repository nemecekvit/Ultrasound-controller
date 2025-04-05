
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



---Counting pure clock cycles
    ---Pros: 
            ---More straighfoward counting
            ---Easier implementation of counter
    ---Cons:
            ---Need to work with decimal numbers, cant use integers

---Counting milimetres
    ---Pros:
            ---Dont have to use decimal number. Can take advantage of bit shifts
            ---Dont have to postprocess data
    ---Cons:
            ---More bloated implementation
            ---Need more help signlas

entity sensor_driver is
    generic (
        TRIG_SIG_LEN        : INTEGER := 1500;
        TRIG_SIG_PERIDOD    : INTEGER := 7_500_000                   
    );
    Port ( 
        clk             : in STD_LOGIC;
        rst             : in STD_LOGIC;
        echo            : in STD_LOGIC;
        trig            : out STD_LOGIC;
        sens_out        : out STD_LOGIC_VECTOR (11 downto 0)
    );
end sensor_driver;

architecture Behavioral of sensor_driver is

    component clock_enable is
        generic (
            N_PERIODS : integer := 6
        );
    
        Port ( 
            clk     : in STD_LOGIC;
            rst     : in STD_LOGIC;
            pulse   : out STD_LOGIC
        );
    end component;

    component trig_generator is
        generic (
            PULSE_LENGHT : INTEGER := 1500                   
        );
 
        Port ( 
            bgn         : in STD_LOGIC;
            clk         : in STD_LOGIC;
            rst         : in STD_LOGIC;
            trig_gen    : out STD_LOGIC
        );
    end component;

    signal trig_clock_pulse : STD_LOGIC;

    signal echo_detected : STD_LOGIC := '0';

    --1 clock cycle is 10 ns; it take sound +-2941 ns to travel 1 mm
    ---I takes 2941/ 10 = 294 clock cycles to to travel 1mm --> 294 * 2 = 558 clock cycles to trvale 1mm round trip
    constant MILIMETER : INTEGER := 588; 

    signal clock_counter : INTEGER range 0 to MILIMETER +1; --- +1 to avoid overflow problems
    signal milim_counter : INTEGER range 0 to 4001; --Max range of HC - SR04 is 4000 mm, so we use 4001 to avoid overflow problems

begin

    clock_enable_trig_clock: clock_enable
        generic map(
            N_PERIODS => TRIG_SIG_PERIDOD
        )
        port map(
            clk => clk,
            rst => rst,
            pulse => trig_clock_pulse 
        );

    triggger_generator: trig_generator
        generic map(
            PULSE_LENGHT => TRIG_SIG_LEN 
        )
        port map(
            bgn => trig_clock_pulse,
            clk => clk,
            rst => rst,
            trig_gen => trig
        );

    process (clk, rst, echo)
    begin
        if echo = '1' and echo_detected = '0' then
            echo_detected <= '1';
            clock_counter <= 0; 
            milim_counter <= 0;
        end if;

        if rising_edge(clk) then
            if rst = '1' then
                sens_out <= (others => '0');
                echo_detected <= '0';
                clock_counter <= 0; 
                milim_counter <= 0;
            end if; 

            if echo = '1' and echo_detected = '1' then      ---echo signal is still active -> count
                if clock_counter = MILIMETER then
                    milim_counter <= milim_counter + 1;
                    clock_counter <= 0;
                else
                    clock_counter <= clock_counter + 1;
                end if;
            elsif echo = '0' and echo_detected = '1' then   ---echo signal ended
                echo_detected <= '0';
                sens_out <= STD_LOGIC_VECTOR(TO_UNSIGNED(milim_counter, 12)); --- Convert number of milimeter into 12 bit vector
            else
                sens_out <= STD_LOGIC_VECTOR(TO_UNSIGNED(milim_counter, 12)); --- Convert number of milimeter into 12 bit vector
            end if;
        end if;
    end process;
end Behavioral;
