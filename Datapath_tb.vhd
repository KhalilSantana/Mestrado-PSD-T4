library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Datapath_tb is
   generic (
      p_WIDTH : integer := 8;
      p_ROWS  : integer := 3;
      p_COLS  : integer := 3
   );
end entity;

architecture tb of Datapath_tb is
   signal w_CLK, w_RST                       : std_logic := '1';
   signal w_MAT_C                            : std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
   signal w_MAT_A_ADDR_ROW, w_MAT_B_ADDR_ROW : std_logic_vector(1 downto 0)         := (others => '0');
   signal w_MAT_A                            : std_logic_vector(8 * 9 - 1 downto 0) :=
   b"0000_0000" & b"0000_0001" & b"0000_0010" & -- | 00 01 02 |     | 02 00 00 |   | (0*2)+(1*3)+(2*4)
   b"0001_0000" & b"0001_0001" & b"0001_0010" & -- | 16 17 18 |  *  | 03 00 00 | = |
   b"0010_0000" & b"0010_0001" & b"0010_0010";  -- | 32 33 34 |     | 04 00 00 |   |
   signal w_MAT_B : std_logic_vector(8 * 9 - 1 downto 0) :=
   b"0000_0010" & b"0000_0000" & b"0000_0000" &
   b"0000_0011" & b"0000_0000" & b"0000_0000" &
   b"0000_0100" & b"0000_0000" & b"0000_0000";

   component Datapath is
      generic (
         p_WIDTH : integer := 8;
         p_ROWS  : integer := 3;
         p_COLS  : integer := 3
      );
      port (
         -- Control pins
         i_CLK            : in std_logic;
         i_RST            : in std_logic;
         i_MAT_A_ADDR_ROW : in std_logic_vector(1 downto 0);
         i_MAT_B_ADDR_ROW : in std_logic_vector(1 downto 0);
         -- Data pins
         i_ENABLE_MAT_A_COUNTER : in std_logic := '0';
   
         i_MAT_A : in std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
         i_MAT_B : in std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
         o_MAT_C : out std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0)
      );
   end component;
begin
   u_Datapath : Datapath port map(
      i_CLK => w_CLK,
      i_RST => w_RST,
      -- i_RST_ACC        => w_RST_ACC,
      i_MAT_A          => w_MAT_A,
      i_MAT_B          => w_MAT_B,
      i_MAT_A_ADDR_ROW => w_MAT_A_ADDR_ROW,
      i_MAT_B_ADDR_ROW => w_MAT_B_ADDR_ROW,
      o_MAT_C          => w_MAT_C
   );
   process (w_CLK)
   begin
      w_CLK <= not w_CLK after 1 ps;
   end process;
   process
   begin
      wait for 1 ps;
      w_RST            <= '0';
      w_MAT_A_ADDR_ROW <= b"00";
      w_MAT_B_ADDR_ROW <= b"00";
      wait for 1.5 ps;
      w_MAT_A_ADDR_ROW <= b"00";
      w_MAT_B_ADDR_ROW <= b"01";
      wait for 1.5 ps;
      w_MAT_A_ADDR_ROW <= b"00";
      w_MAT_B_ADDR_ROW <= b"10";
      wait;
   end process;
end architecture;