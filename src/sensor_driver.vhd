
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
        CLK100MHZ       : in STD_LOGIC;
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

    component echo_processor is
        Port ( 
            clk             : in STD_LOGIC;
            rst             : in STD_LOGIC;
            echo_in         : in STD_LOGIC;
            data_out        : out STD_LOGIC_VECTOR (11 downto 0)
        );
    end component;

    signal trig_clock_pulse : STD_LOGIC;

begin

    clock_enable_trig_clock: clock_enable
        generic map(
            N_PERIODS => TRIG_SIG_PERIDOD
        )
        port map(
            clk => CLK100MHZ,
            rst => rst,
            pulse => trig_clock_pulse 
        );

    triggger_generator: trig_generator
        generic map(
            PULSE_LENGHT => TRIG_SIG_LEN 
        )
        port map(
            bgn => trig_clock_pulse,
            clk => CLK100MHZ,
            rst => rst,
            trig_gen => trig
        );

    echo_process: echo_processor
        port map(
            clk => CLK100MHZ,
            rst => rst,
            echo_in => echo,
            data_out => sens_out
        );

    end Behavioral;
