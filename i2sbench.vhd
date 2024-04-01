library IEEE;
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.NUMERIC_STD.ALL;
use std.env.finish;

entity i2sbench is
end;

architecture testbench of i2sbench is
      signal reset_n : std_logic := '0'; 
      signal mclk : std_logic := '0';
      signal lrclk : std_logic;
      signal sclk : std_logic;
      signal da_sdin : std_logic;
      signal ad_sdout : std_logic := '0';
      signal lr_en : std_logic;
      signal lout : std_logic_vector(31 downto 0);
      signal rout : std_logic_vector(31 downto 0);
      signal lin : std_logic_vector(31 downto 0) := (others => '0');
      signal rin : std_logic_vector(31 downto 0) := (others => '0');
begin

  reset_n <= '1' after 20 ns;
  mclk <= not mclk after 10 ns;
  ad_sdout <= da_sdin;

  stimulus:
  process begin
    wait until (reset_n = '1');
    lin <= "10101000111100001111110010101001";
    rin <= "11100111100011100011010101101100";
    wait for 6*256*10 ns;

    finish;
  end process stimulus;

i2s_inst : entity work.i2s
  port map (
    reset_n => reset_n,
    mclk => mclk,
    lrclk => lrclk,
    sclk => sclk,
    da_sdin => da_sdin,
    ad_sdout => ad_sdout,
    lr_en => lr_en,
    lout => lout,
    rout => rout,
    lin => lin,
    rin => rin
  );

end architecture;