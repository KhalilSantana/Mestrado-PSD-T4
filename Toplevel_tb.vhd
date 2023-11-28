library ieee;
use ieee.std_logic_1164.all;

entity Toplevel_tb is
   generic (
      p_WIDTH : integer := 8;
      p_ROWS  : integer := 3;
      p_COLS  : integer := 3
   );
end entity;
architecture tb of Toplevel_tb is
   signal w_CLK, w_RST : std_logic := '1';
   signal w_START      : std_logic := '0';
   signal w_RDY        : std_logic := '0';
   signal w_MAT_C      : std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
   signal w_MAT_A      : std_logic_vector(8 * 9 - 1 downto 0) :=
   b"0000_0000" & b"0000_0001" & b"0000_0010" & -- | 00 01 02 |     | 02 05 06 |   | (0*2)+(1*3)+(2*4)
   b"0000_0011" & b"0000_0100" & b"0000_0101" & -- | 03 04 05 |  *  | 03 08 07 | = |
   b"0000_0110" & b"0000_0111" & b"0000_1000";  -- | 06 07 08 |     | 04 01 00 |   |
   signal w_MAT_B : std_logic_vector(8 * 9 - 1 downto 0) :=
   b"0000_0010" & b"0000_0101" & b"0000_0110" &
   b"0000_0011" & b"0000_1000" & b"0000_0111" &
   b"0000_0100" & b"0000_0001" & b"0000_0000";

   component Toplevel is
      generic (
         p_WIDTH : integer := 8;
         p_ROWS  : integer := 3;
         p_COLS  : integer := 3
      );
      port (
         -- Control pins
         i_CLK   : in std_logic;
         i_RST   : in std_logic;
         o_RDY   : out std_logic;
         i_START : in std_logic;
         -- Data pins
         i_MAT_A : in std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
         i_MAT_B : in std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
         o_MAT_C : out std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0)
      );
   end component;

begin
   u_Toplevel : Toplevel port map(
      i_CLK => w_CLK,
      i_RST => w_RST,
      o_RDY => w_RDY,
      --
      i_START => w_START,
      i_MAT_A => w_MAT_A,
      i_MAT_B => w_MAT_B,
      o_MAT_C => w_MAT_C
   );
   process (w_CLK)
   begin
      w_CLK <= not w_CLK after 1 ps;
   end process;
   process
   begin
      w_RST <= '0';
      wait for 5 ps;
      w_START <= '1';
      wait for 25 ps;
      wait;
   end process;
end architecture;