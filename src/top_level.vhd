library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
    Port (
        CLK100MHZ    : in    std_logic;
        BTNC         : in    std_logic;
        SW           : in    std_logic_vector(15 downto 12);
        JCI          : in    std_logic_vector(4 downto 1);
        CA           : out   std_logic;                   
        CB           : out   std_logic;                
        CC           : out   std_logic;
        CD           : out   std_logic; 
        CE           : out   std_logic;
        CF           : out   std_logic;
        CG           : out   std_logic;
        DP           : out   std_logic;
        AN           : out   std_logic_vector(7 downto 0);
        JCO          : out   std_logic_vector(10 downto 7)
    );
end entity top_level;

architecture Behavioral of top_level is
    component sensor_driver is
        generic (
            TRIG_SIG_LEN        : INTEGER;
            TRIG_SIG_PERIDOD    : INTEGER                    
        );
        port (
            CLK100MHZ   : in    std_logic;
            echo        : in    std_logic;
            rst         : in    std_logic;      
            sens_out    : out   std_logic_vector(11 downto 0);
            trig        : out   std_logic
        );
    end component;

    component sensor_select is
        port (
            sens_in_1   : in std_logic_vector(11 downto 0);
            sens_in_2   : in std_logic_vector(11 downto 0);
            sens_in_3   : in std_logic_vector(11 downto 0);
            sens_in_4   : in std_logic_vector(11 downto 0);
            select_in   : in std_logic_vector(3 downto 0);
            data_out    : out std_logic_vector(11 downto 0);
            select_out  : out std_logic_vector(3 downto 0)
        );
    end component;

    component display_controller is
        port (
            CLK100MHZ   : in std_logic;
            data_in     : in std_logic_vector(11 downto 0);
            select_in   : in std_logic_vector(3 downto 0);
            rst         : in std_logic;
            seg         : out std_logic_vector(6 downto 0);
            DP          : out std_logic;
            AN          : out std_logic_vector(7 downto 0)
        );
    end component;

    signal sens_1   : std_logic_vector(11 downto 0);
    signal sens_2   : std_logic_vector(11 downto 0);
    signal sens_3   : std_logic_vector(11 downto 0);
    signal sens_4   : std_logic_vector(11 downto 0);
    signal trig_sig : std_logic_vector(10 downto 7);
    signal data     : std_logic_vector(11 downto 0);
    signal slc      : std_logic_vector(3 downto 0);

begin

    sense_drive_1 : component sensor_driver
        generic map (
            TRIG_SIG_LEN => 1500,
            TRIG_SIG_PERIDOD => 7_500_000
        )
        port map (
            CLK100MHZ   => CLK100MHZ,
            echo        => JCI(1),
            rst         => BTNC,
            sens_out    => sens_1,
            trig        => trig_sig(7)
        );
    
    sense_drive_2 : component sensor_driver
        generic map (
            TRIG_SIG_LEN => 1500,
            TRIG_SIG_PERIDOD => 7_500_000
        )
        port map (
            CLK100MHZ   => CLK100MHZ,
            echo        => JCI(2),
            rst         => BTNC,
            sens_out    => sens_2,
            trig        => trig_sig(8)
        );

    sense_drive_3 : component sensor_driver
        generic map (
            TRIG_SIG_LEN => 1500,
            TRIG_SIG_PERIDOD => 7_500_000
        )
        port map (
            CLK100MHZ   => CLK100MHZ,
            echo        => JCI(3),
            rst         => BTNC,
            sens_out    => sens_3,
            trig        => trig_sig(9)
        );

    sense_drive_4 : component sensor_driver
        generic map (
            TRIG_SIG_LEN => 1500,
            TRIG_SIG_PERIDOD => 7_500_000
        )
        port map (
            CLK100MHZ   => CLK100MHZ,
            echo        => JCI(4),
            rst         => BTNC,
            sens_out    => sens_4,
            trig        => trig_sig(10)
        );

    sense_select : component sensor_select
        port map(
            sens_in_1   => sens_1,
            sens_in_2   => sens_2,
            sens_in_3   => sens_3,
            sens_in_4   => sens_4,
            select_in   => SW,
            data_out    => data,
            select_out  => slc
        );

    disp_controller : component display_controller
        port map(
            CLK100MHZ   => CLK100MHZ,
            data_in     => data,
            select_in   => slc,
            rst         => BTNC,
            seg(6)      => CA,
            seg(5)      => CB,
            seg(4)      => CC,
            seg(3)      => CD,
            seg(2)      => CE,
            seg(1)      => CF,
            seg(0)      => CG,
            DP          => DP,
            AN          => AN
        );

    JCO <= trig_sig;

end architecture Behavioral;