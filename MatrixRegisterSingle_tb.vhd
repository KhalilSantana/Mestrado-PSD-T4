library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MatrixRegisterSingle_tb is
   generic (
      p_WIDTH : integer := 8;
      p_ROWS  : integer := 3;
      p_COLS  : integer := 3
   );
end entity;
architecture tb of MatrixRegisterSingle_tb is
   signal w_CLK, w_RST           : std_logic := '1';
   signal w_ADDR_ROW, w_ADDR_COL : std_logic_vector(1 downto 0);
   signal w_D                    : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_Q                    : std_logic_vector(p_WIDTH * p_ROWS * p_COLS - 1 downto 0);
   component MatrixRegisterSingle is
      generic (
         p_WIDTH : integer := 8;
         p_ROWS  : integer := 3;
         p_COLS  : integer := 3
      );
      port (
         i_CLK      : in std_logic;
         i_RST      : in std_logic;
         i_ADDR_ROW : in std_logic_vector(1 downto 0);
         i_ADDR_COL : in std_logic_vector(1 downto 0);
         i_D        : in std_logic_vector(p_WIDTH - 1 downto 0);
         o_Q        : out std_logic_vector(p_WIDTH * p_ROWS * p_COLS - 1 downto 0)
      );
   end component;
begin
   u_MatrixRegisterSingle : MatrixRegisterSingle port map(
      i_CLK      => w_CLK,
      i_RST      => w_RST,
      i_ADDR_ROW => w_ADDR_ROW,
      i_ADDR_COL => w_ADDR_COL,
      i_D        => w_D,
      o_Q        => w_Q
   );
   process (w_CLK)
   begin
      w_CLK <= not w_CLK after 1 ps;
   end process;
   process
   begin
      w_RST <= '0';
      wait for 1 ps;
      w_D        <= b"0000_0001";
      w_ADDR_ROW <= "00";
      w_ADDR_COL <= "00";
      wait for 1.5 ps;
      assert w_Q =
      b"0000_0001" & b"0000_0000" & b"0000_0000" &
      b"0000_0000" & b"0000_0000" & b"0000_0000" &
      b"0000_0000" & b"0000_0000" & b"0000_0000"
      severity error;
      w_D        <= b"0000_0010";
      w_ADDR_ROW <= "00";
      w_ADDR_COL <= "01";
      wait for 1.5 ps;
      assert w_Q =
      b"0000_0001" & b"0000_0010" & b"0000_0000" &
      b"0000_0000" & b"0000_0000" & b"0000_0000" &
      b"0000_0000" & b"0000_0000" & b"0000_0000"
      severity error;
      w_D        <= b"0000_0011";
      w_ADDR_ROW <= "00";
      w_ADDR_COL <= "10";
      wait for 1.5 ps;
      assert w_Q =
      b"0000_0001" & b"0000_0010" & b"0000_0011" &
      b"0000_0000" & b"0000_0000" & b"0000_0000" &
      b"0000_0000" & b"0000_0000" & b"0000_0000"
      severity error;
      w_D        <= b"0000_0100";
      w_ADDR_ROW <= "01";
      w_ADDR_COL <= "00";
      wait for 1.5 ps;
      assert w_Q =
      b"0000_0001" & b"0000_0010" & b"0000_0011" &
      b"0000_0100" & b"0000_0000" & b"0000_0000" &
      b"0000_0000" & b"0000_0000" & b"0000_0000"
      severity error;
      w_D        <= b"0000_0101";
      w_ADDR_ROW <= "01";
      w_ADDR_COL <= "01";
      wait for 1.5 ps;
      assert w_Q =
      b"0000_0001" & b"0000_0010" & b"0000_0011" &
      b"0000_0100" & b"0000_0101" & b"0000_0000" &
      b"0000_0000" & b"0000_0000" & b"0000_0000"
      severity error;
      -- TODO Finish this testbench
      wait;
   end process;
end architecture;