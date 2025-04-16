library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity display_controller is
    Generic(
        N_PERIODS : integer := 100_000
    );
    Port ( CLK100MHZ : in STD_LOGIC;
           rst : in STD_LOGIC;
           data_in : in STD_LOGIC_VECTOR (11 downto 0);
           select_in : in STD_LOGIC_VECTOR (3 downto 0);
           seg : out STD_LOGIC_VECTOR (6 downto 0);
           DP :out STD_LOGIC;
           AN   : out STD_LOGIC_VECTOR (7 downto 0));
end display_controller;

architecture Behavioral of display_controller is
    component bin2seg
    port (
        clear : in  STD_LOGIC;
        bcd   : in  STD_LOGIC_VECTOR (3 downto 0);
        seg   : out STD_LOGIC_VECTOR (6 downto 0)
    );
    end component;
    
    component clock_enable
        generic (
            N_PERIODS : integer := 100_000
        );
        port (
           clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           pulse : out STD_LOGIC
        );
    end component;
    
    component control
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
    end component;
    
    component bin2bcd
    Port (
        clk       : in  std_logic;
        rst       : in  std_logic;
        binary_in : in  std_logic_vector(11 downto 0);  
        bcd_out0  : out std_logic_vector(3 downto 0);
        bcd_out1  : out std_logic_vector(3 downto 0);
        bcd_out2  : out std_logic_vector(3 downto 0);
        bcd_out3  : out std_logic_vector(3 downto 0)   
    );
    end component;
    
    signal clk2 : std_logic;
    signal bcdin0 : std_logic_vector(3 downto 0);
    signal bcdin1 : std_logic_vector(3 downto 0);
    signal bcdin2 : std_logic_vector(3 downto 0);
    signal bcdin3 : std_logic_vector(3 downto 0);
    signal bcdout : std_logic_vector(3 downto 0);
begin
    CLOCK : clock_enable
    generic map(
        N_PERIODS => 100_000
    )
    port map (
           clk => CLK100MHZ,
           rst => rst,
           pulse => clk2);
           
     CONTROLLER : control
     port map(
            clk => clk2,
            bcd_in0 => bcdin0,
            bcd_in1 => bcdin1,
            bcd_in2 => bcdin2,
            bcd_in3 => bcdin3,
            disp_in => select_in,
            bcd_out => bcdout,
            an => an,
            dp => dp);
            
     BCD : bin2bcd
     port map(
            binary_in => data_in,
            clk => CLK100MHZ,
            rst => rst,
            bcd_out0 => bcdin0,
            bcd_out1 => bcdin1,
            bcd_out2 => bcdin2,
            bcd_out3 => bcdin3
    );

    DISP : bin2seg
    port map (
        clear   => rst,
        bcd => bcdout,
        seg => seg
    );
end Behavioral;