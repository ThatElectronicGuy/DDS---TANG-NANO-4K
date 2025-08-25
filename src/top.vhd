Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.counter_8bit;
use work.counter_32bit;
use work.LSB_bit_shift_register_4bit;
use work.LSB_bit_shift_register_32bit;
use work.ROM_Triangle_Wave;
use work.ROM_Sawtooth_Wave;
use work.ROM_Reverse_Sawtooth_Wave;
use work.ROM_Sine_Wave;

entity top is
    Port (
            CLK_27MHZ : in STD_LOGIC;
            CLK_100MHZ : out STD_LOGIC;
            LED : out STD_LOGIC;
            CS32 : in STD_LOGIC;
            CS4 : in STD_LOGIC;
            MOSI : in STD_LOGIC;
            MSCLK : in STD_LOGIC; -- MSCLK from uC side
            Square_Wave_IO_Toggle_PIN : out STD_LOGIC;
            DAC_Output : out STD_LOGIC_VECTOR (15 downto 0);
            DEBUG : out STD_LOGIC
         );
end top;

architecture Behavioral of top is
    --
    constant MAX32 : unsigned (31 downto 0) := (others => '1');
    signal Q2 : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal Q : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
    signal LED_flag : STD_LOGIC := '0';
    signal DEBUG_s : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
    --

------------------------------------------------------------------------------------------------------------------------------------------------------------

    -- Signals necessary for Input demultiplexer
    signal Output32SPIIN : STD_LOGIC := '0';
    signal Output4SPIIN : STD_LOGIC := '0';
    --

    -- Signals responsible for bit shift registers
    signal Q4BS : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
    signal Q32BS : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal Reset_All : STD_LOGIC := '0';
    --

    -- Signals needed for 32 bit ROM counter
    signal Enable_stepcounter : STD_LOGIC := '0';
    signal Incrementing_Step : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    signal Output32_Rom_Counter : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

    -- Signals needed for 32 bit Comparator counter for square wave generation
    signal clock_300MHZ : STD_LOGIC;
    signal Output_Comparator_Counter : STD_LOGIC_VECTOR (31 downto 0);
    signal reset_comparator : STD_LOGIC := '0';
    --

    -- Signal that is needed for demultiplexer that routes 32 BSR output
    signal Comparator_Storage : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
    --

    -- Signal for initialization of Square_Wave_IO_Toggle_PIN
    signal Square_Wave_S : STD_LOGIC := '0';
    --
    
    -- Signals used in all ROMS
    attribute keep : integer;


    signal Triangle_Wave_Address : STD_LOGIC_VECTOR (5 downto 0);
    signal Triangle_Wave_DAC_Drive : STD_LOGIC_VECTOR (15 downto 0);
    attribute keep of Triangle_Wave_DAC_Drive : signal is 1;
    attribute keep of Triangle_Wave_Address : signal is 1;


    signal Sawtooth_Wave_Address : STD_LOGIC_VECTOR (5 downto 0);
    signal Sawtooth_Wave_DAC_Drive : STD_LOGIC_VECTOR (15 downto 0);
    attribute keep of Sawtooth_Wave_DAC_Drive : signal is 1;
    attribute keep of Sawtooth_Wave_Address : signal is 1;


    signal Reverse_Sawtooth_Wave_Address : STD_LOGIC_VECTOR (5 downto 0);
    signal Reverse_Sawtooth_Wave_DAC_Drive : STD_LOGIC_VECTOR (15 downto 0);
    attribute keep of Reverse_Sawtooth_Wave_DAC_Drive : signal is 1;
    attribute keep of Reverse_Sawtooth_Wave_Address : signal is 1;


    signal Sine_Wave_Address : STD_LOGIC_VECTOR (5 downto 0);
    signal Sine_Wave_DAC_Drive : STD_LOGIC_VECTOR (15 downto 0);
    attribute keep of Sine_Wave_DAC_Drive : signal is 1;
    attribute keep of Sine_Wave_Address : signal is 1;

    signal Address6 : STD_LOGIC_VECTOR (5 downto 0) := (others => '0');
    --

    -- Output to DAC
    signal To_DAC : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
    --

    -- Seprate Clock needed becaused of DAC limitation 125MSPS
    signal clock_100MHZ : STD_LOGIC;
    --

    -- debug signals
    signal CS4_s : STD_LOGIC := '1';
    signal CS32_s : STD_LOGIC := '1';
    --

    -- pll status signal that returns 0 or 1, success or no
    signal PLL_Status : STD_LOGIC := '0';
    --

    -------------------------------------------------------------------------------------------------------------------------------------------------------------

begin

    -- Demultiplexer for SPI input
    Output32SPIIN <= MOSI when (CS32_s = '0' and CS4_s = '1') else '0';
    Output4SPIIN <= MOSI when (CS4_s = '0' and CS32_s = '1') else '0';
    --

    -- instantiating 4 bit shift register
    bit_shift_register_4 : entity work.LSB_bit_shift_register_4bit
    port map
    (
        D => Output4SPIIN,
        Q => Q4BS,
        CLK => MSCLK,
        RESET => Reset_All,
        ENABLE => (not CS4_s)
    );
    --

    -- instatiating 32 bit shift register
    bit_shift_register_32 : entity work.LSB_bit_shift_register_32bit
    port map
    (
        D => Output32SPIIN,
        Q => Q32BS,
        CLK => MSCLK,
        RESET => Reset_All,
        ENABLE => (not CS32_s)
    );
    --



    -- instantiating 32 bit counter for ROM verting
    ROM_Counter32 : entity work.counter_32bit
    port map
    (
        CLK => clock_100MHZ,
        ENABLE => '1',
        RESET => '0',
        D => Incrementing_Step,
        Q => Output32_Rom_Counter,
        ARESET => '0'
    );
    --

    -- instantiating 32bit comparator counter
    Comparator_Counter32 : entity work.counter_32bit
    port map
    (
        CLK => CLK_27MHZ,
        ENABLE => Q4BS(0),
        RESET => reset_comparator,
        D => x"00000001",
        Q => Output_Comparator_Counter,
        ARESET => '0'
    );

    -- performing logic for enabling of rom counter and direction of 32BS Register output
    Enable_stepcounter <= '1' when (CS32 = '1' and CS4 = '1' and Q4BS(0) = '0') else '0';

    Incrementing_Step <= Q32BS when Q4BS(0) = '0' else (others => '0');
    Comparator_Storage <= Q32BS when Q4BS(0) = '1' else (others => '0');
    --

    -- Comparator Logic
    process (CLK_27MHZ)
    begin
    if rising_edge (CLK_27MHZ) then
    if Output_Comparator_Counter = Comparator_Storage then
        Square_Wave_S <= not Square_Wave_S;
        reset_comparator <= '1';
    else
        reset_comparator <= '0';
    end if;
    end if;
    end process;

    Square_Wave_IO_Toggle_PIN <= Square_Wave_S;
    LED <= Square_Wave_S;
    --




    -- Instantiating Triangle Wave ROM
    Triangle_Wave : entity work.ROM_Triangle_Wave
    port map 
    (
        dout => Triangle_Wave_DAC_Drive,
        clk => clock_100MHZ,
        oce => not Q4BS(0),                 -- enable
        ce => not Q4BS(0),                  -- chip enable?
        reset => '0',
        ad => Triangle_Wave_Address
    );
    --

    -- Instantiating Sawtooth Wave ROM
    Sawtooth_Wave : entity work.ROM_Sawtooth_Wave
    port map
    (
        dout => Sawtooth_Wave_DAC_Drive,
        clk => clock_100MHZ,
        oce => not Q4BS(0),
        ce => not Q4BS(0),
        reset => '0',
        ad => Sawtooth_Wave_Address
    );
    --

    -- Instantiating Reverse Sawtooth ROM
    Reverse_Sawtooth : entity work.ROM_Reverse_Sawtooth_Wave
    port map
    (
        dout => Reverse_Sawtooth_Wave_DAC_Drive,
        clk => clock_100MHZ,
        oce => not Q4BS(0),
        ce => not Q4BS(0),
        reset => '0',
        ad => Reverse_Sawtooth_Wave_Address
    );
    --

    -- Instantiating Sine ROM
    Sine : entity work.ROM_Sine_Wave
    port map
    (
        dout => Sine_Wave_DAC_Drive,
        clk => clock_100MHZ,
        oce => not Q4BS(0),
        ce => not Q4BS(0),
        reset => '0',
        ad => Sine_Wave_Address
    );

    -- filling signal that will hold 6 adddress bits from step incrementing counter
    Address6 <= Output32_Rom_Counter (31 downto 26);
    --

    -- Demultiplexer that routes addresses for the right wave form ROM
--    Triangle_Wave_Address <= Address6 when (Q4BS(3) = '0' and Q4BS(2) = '0' and Q4BS(1) = '1') else (others => '0');
--    Sawtooth_Wave_Address <= Address6 when (Q4BS(3) = '0' and Q4BS(2) = '1' and Q4BS(1) = '0') else (others => '0');
--    Reverse_Sawtooth_Wave_Address <= Address6 when (Q4BS(3) = '1' and Q4BS(2) = '0' and Q4BS(1) = '0') else (others => '0');
--    Sine_Wave_Address <= Address6 when (Q4BS(3) = '0' and Q4BS(2) = '1' and Q4BS(1) = '1') else (others => '0');
    Triangle_Wave_Address <= Address6;
    Sawtooth_Wave_Address <= Address6;
    Reverse_Sawtooth_Wave_Address <= Address6;
    Sine_Wave_Address <= Address6;
    --

    -- Multiplexer that routes the right ROM to the DAC
    with Q4BS(3 downto 1) select
        To_DAC <= Triangle_Wave_DAC_Drive when "001",
                  Sawtooth_Wave_DAC_Drive when "010",
                  Reverse_Sawtooth_Wave_DAC_Drive when "100",
                  Sine_Wave_DAC_Drive when "011",
                  (others => '0') when others;
    --

    -- Mapping signal to physical port
    DAC_Output <= To_DAC;
    --

    -- Assigning Reset_All function for "111"
    --Reset_All <= '1' when (Q4BS(3) = '1' and Q4BS(2) = '1' and Q4BS(1) = '1') else '0';
    Reset_All <= '1';
    -- Here i need to reset initial values of registers otherwise they are always 0 (I did it for testing purposes)

    -- Assigning clock to the output port so that I can give 100 mhz to DAC from inside of fpga
    CLK_100MHZ <= clock_100MHZ;
    --


    -- Debugging
    DEBUG <= PLL_Status;
    --






-----------------------------------------------------------------------------------------------
    --instantiating PLL
    PLL : entity work.Gowin_PLLVR
    port map
    (
        clkout => clock_300MHZ,
        lock => PLL_Status,
        clkoutd3 => clock_100MHZ,
        clkin => CLK_27MHZ
    );

end Behavioral;