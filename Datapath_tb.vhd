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
   signal w_MAT_C                            : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_MAT_A_ADDR_ROW, w_MAT_B_ADDR_ROW : std_logic_vector(1 downto 0)         := (others => '0');
   signal w_MAT_A_ADDR_COL, w_MAT_B_ADDR_COL : std_logic_vector(1 downto 0)         := (others => '0');
   signal w_MAT_A                            : std_logic_vector(8 * 9 - 1 downto 0) := b"1111_1111" & b"1111_1111" & b"1111_1111" &
   b"1111_1111" & b"1111_1111" & b"1111_1111" &
   b"1111_1111" & b"1111_1111" & b"1111_1111";
   signal w_MAT_B : std_logic_vector(8 * 9 - 1 downto 0) := b"1111_1111" & b"1111_1111" & b"1111_1111" &
   b"1111_1111" & b"1111_1111" & b"1111_1111" &
   b"1111_1111" & b"1111_1111" & b"1111_1111";

   component Datapath is
      generic (
         p_WIDTH : integer := 8;
         p_ROWS  : integer := 3;
         p_COLS  : integer := 3
      );
      port (
         i_CLK                              : in std_logic;
         i_RST                              : in std_logic;
         i_MAT_A                            : in std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
         i_MAT_B                            : in std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
         i_MAT_A_ADDR_ROW, i_MAT_A_ADDR_COL : in std_logic_vector(1 downto 0);
         i_MAT_B_ADDR_ROW, i_MAT_B_ADDR_COL : in std_logic_vector(1 downto 0);
         o_MAT_C                            : out std_logic_vector(p_WIDTH - 1 downto 0)
      );
   end component;
begin
   u_Datapath : Datapath port map(
      i_CLK            => w_CLK,
      i_RST            => w_RST,
      i_MAT_A          => w_MAT_A,
      i_MAT_B          => w_MAT_B,
      i_MAT_A_ADDR_ROW => w_MAT_A_ADDR_ROW,
      i_MAT_A_ADDR_COL => w_MAT_A_ADDR_COL,
      i_MAT_B_ADDR_ROW => w_MAT_B_ADDR_ROW,
      i_MAT_B_ADDR_COL => w_MAT_B_ADDR_COL,
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
      w_MAT_A_ADDR_ROW <= b"11";
      w_MAT_A_ADDR_COL <= b"11";

      w_MAT_B_ADDR_ROW <= b"11";
      w_MAT_B_ADDR_COL <= b"11";
      wait for 1.5 ps;
      assert w_MAT_C = b"0000_0110"
      report "3*2 != 6"
         severity error;
      wait;
   end process;
end architecture;