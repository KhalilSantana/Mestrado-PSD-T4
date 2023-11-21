library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Accumulator_tb is
   generic (
      p_WIDTH : integer := 8;
      p_ROWS  : integer := 3;
      p_COLS  : integer := 3
   );
end entity;
architecture tb of Accumulator_tb is
   signal w_CLK, w_RST : std_logic                              := '1';
   signal w_D, w_Q     : std_logic_vector(p_WIDTH - 1 downto 0) := (others => '0');
   component Accumulator is
      generic (
         p_WIDTH : integer := 8;
         p_ROWS  : integer := 3;
         p_COLS  : integer := 3
      );
      port (
         i_CLK : in std_logic;
         i_RST : in std_logic;
         i_D   : in std_logic_vector(p_WIDTH - 1 downto 0);
         o_Q   : out std_logic_vector(p_WIDTH - 1 downto 0)
      );
   end component;
begin

   process (w_CLK)
   begin
      w_CLK <= not w_CLK after 1 ps;
   end process;
   u_Acc : Accumulator port map(
      i_CLK => w_CLK,
      i_RST => w_RST,
      i_D   => w_D,
      o_Q   => w_Q
   );
   process
   begin
      wait for 1 ps;
      w_RST <= '0';
      wait for 1.5 ps;
      w_D <= b"0000_0001";
      wait for 1.5 ps;
      assert w_Q = b"0000_0001"
      report "0+1 != 1"
         severity error;

      w_D <= b"0000_0010";
      wait for 1.5 ps;
      assert w_Q = b"0000_0011"
      report "1+2 != 3"
         severity error;
      wait;
   end process;
end architecture;