library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity i2s is
  port
  (
    reset_n : in std_logic;
    mclk  : in std_logic;
    lrclk : out std_logic;
    sclk  : out std_logic;
    da_sdin  : out std_logic;
    ad_sdout : in std_logic;

    lr_en : out std_logic;
    lout : out std_logic_vector(31 downto 0);
    rout : out std_logic_vector(31 downto 0);

    lin : in std_logic_vector(31 downto 0);
    rin : in std_logic_vector(31 downto 0)
  );
end i2s;

architecture Behavioral of i2s is
  signal lsample_reg_sig : std_logic_vector(31 downto 0);
  signal rsample_reg_sig : std_logic_vector(31 downto 0);
begin

  process (mclk, reset_n)
    variable counter    : unsigned(7 downto 0) := (others => '0');
    variable en_sample  : std_logic := '0';
    variable en_bit     : std_logic := '0';
    variable lsample_reg    : std_logic_vector(31 downto 0) := (others => '0');
    variable rsample_reg    : std_logic_vector(31 downto 0) := (others => '0');
  begin
    if reset_n = '0' then
      counter := "00000000";
      sclk <= '0';
      lrclk <= '0';
      lr_en <= '0';
      lout <= (others => '0');
      rout <= (others => '0');
      da_sdin <= '0';
    elsif rising_edge(mclk) then
      counter := counter + 1;
      sclk <= counter(1);
      lrclk <= counter(7);
      if counter = "00000000" then
        lout <= lsample_reg;
        rout <= rsample_reg;
        lsample_reg := lin;
        rsample_reg := rin;
        lr_en <= '1';
      else
        lr_en <= '0';
      end if;
      if counter(1 downto 0) = "00" then
        if lrclk = '0' then
          da_sdin <= lsample_reg(31);
        else
          da_sdin <= rsample_reg(31);
        end if;
      end if;
      if counter(1 downto 0) = "10" then
        if lrclk = '0' then
          lsample_reg := lsample_reg(30 downto 0) & ad_sdout;
        else
          rsample_reg := rsample_reg(30 downto 0) & ad_sdout;
        end if;
      end if;
    end if;
  end process;


end Behavioral;