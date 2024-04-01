library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity speaker is
  port
  (
    CLOCK : in std_logic;

    -- pmodi2s2
    da_mclk  : out std_logic;
    da_lrclk : out std_logic;
    da_sclk  : out std_logic;
    da_sdin  : out std_logic;

    ad_mclk  : out std_logic;
    ad_lrclk : out std_logic;
    ad_sclk  : out std_logic;
    ad_sdout : in std_logic
  );
end speaker;

architecture Behavioral of speaker is

  signal mclk    : std_logic;
  signal lrclk   : std_logic;
  signal sclk    : std_logic;
  signal reset_n : std_logic;

  component pll
    port
    (
      clock_in  : in std_logic;
      clock_out : out std_logic;
      locked    : out std_logic
    );
  end component;

begin

  process (mclk, reset_n)
    variable counter    : unsigned(7 downto 0);
  begin
    if reset_n = '0' then
      counter := "00000000";
    elsif rising_edge(mclk) then
      counter := counter + 1;
      sclk <= counter(1);
      lrclk <= counter(7);
    end if;
  end process;

  da_sdin  <= ad_sdout;
  ad_lrclk <= lrclk;
  ad_sclk  <= sclk;
  ad_mclk  <= mclk;
  da_lrclk <= lrclk;
  da_sclk  <= sclk;
  da_mclk  <= mclk;

  mclk <= CLOCK;
  reset_n <= '1';
  -- pll_inst : pll
  -- port map
  -- (
  --   clock_in  => CLOCK,
  --   clock_out => mclk,
  --   locked    => reset_n
  -- );

end Behavioral;