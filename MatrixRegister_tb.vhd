library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MatrixRegister_tb is
   generic (
      p_WIDTH : integer := 8;
      p_ROWS  : integer := 3;
      p_COLS  : integer := 3
   );
end entity;
architecture tb of MatrixRegister_tb is
   signal w_CLK, w_RST           : std_logic                    := '1';
   signal w_ADDR_ROW, w_ADDR_COL : std_logic_vector(1 downto 0) := "00";
   signal w_OUTPUT_ELEMENT       : std_logic_vector(8 - 1 downto 0);
   signal w_INPUT_MAT            : std_logic_vector(8 * 9 - 1 downto 0) := b"0000_0000" & b"0000_0001" & b"0000_0010" &
   b"0001_0000" & b"0001_0001" & b"0001_0010" &
   b"0010_0000" & b"0010_0001" & b"0010_0010";
   component MatrixRegister is
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
         i_D        : in std_logic_vector(p_WIDTH * p_ROWS * p_COLS - 1 downto 0);
         o_Q        : out std_logic_vector(p_WIDTH - 1 downto 0)
      );
   end component;
begin
   u_MatReg : MatrixRegister port map(
      i_CLK      => w_CLK,
      i_RST      => w_RST,
      i_ADDR_ROW => w_ADDR_ROW,
      i_ADDR_COL => w_ADDR_COL,
      i_D        => w_INPUT_MAT,
      o_Q        => w_OUTPUT_ELEMENT
   );
   process (w_CLK)
   begin
      w_CLK <= not w_CLK after 1 ps;
   end process;
   process
   begin
      wait for 1 ps;
      w_RST <= '0';
      -- @@@@ ROW 0
      wait for 1.5 ps;
      w_ADDR_ROW <= b"00";
      w_ADDR_COL <= b"00";
      wait for 1 ps;
      assert w_OUTPUT_ELEMENT = b"0000_0000"
      report "mat(0,0)!= 0000_0000"
         severity error;

      wait for 1.5 ps;
      w_ADDR_ROW <= b"00";
      w_ADDR_COL <= b"01";
      wait for 1 ps;
      assert w_OUTPUT_ELEMENT = b"0000_0001"
      report "mat(0,1)!= 0000_0001"
         severity error;

      wait for 1.5 ps;
      w_ADDR_ROW <= b"00";
      w_ADDR_COL <= b"10";
      wait for 1 ps;
      assert w_OUTPUT_ELEMENT = b"0000_0010"
      report "mat(0,2)!= 0000_0010"
         severity error;

      -- @@@@ ROW 1
      wait for 1.5 ps;
      w_ADDR_ROW <= b"01";
      w_ADDR_COL <= b"00";
      wait for 1 ps;
      assert w_OUTPUT_ELEMENT = b"0001_0000"
      report "mat(1,0)!= 0001_0000"
         severity error;

      wait for 1.5 ps;
      w_ADDR_ROW <= b"01";
      w_ADDR_COL <= b"01";
      wait for 1 ps;
      assert w_OUTPUT_ELEMENT = b"0001_0001"
      report "mat(1,1)!= 0001_0001"
         severity error;

      wait for 1.5 ps;
      w_ADDR_ROW <= b"01";
      w_ADDR_COL <= b"10";
      wait for 1 ps;
      assert w_OUTPUT_ELEMENT = b"0001_0010"
      report "mat(1,2)!= 0001_0010"
         severity error;

      -- @@@@ ROW 3
      wait for 1.5 ps;
      w_ADDR_ROW <= b"10";
      w_ADDR_COL <= b"00";
      wait for 1 ps;
      assert w_OUTPUT_ELEMENT = b"0010_0000"
      report "mat(2,0)!= 0010_0000"
         severity error;

      wait for 1.5 ps;
      w_ADDR_ROW <= b"10";
      w_ADDR_COL <= b"01";
      wait for 1 ps;
      assert w_OUTPUT_ELEMENT = b"0010_0001"
      report "mat(2,1)!= 0010_0001"
         severity error;

      wait for 1.5 ps;
      w_ADDR_ROW <= b"10";
      w_ADDR_COL <= b"10";
      wait for 1 ps;
      assert w_OUTPUT_ELEMENT = b"0010_0010"
      report "mat(2,2)!= 0001_0001"
         severity error;

      wait;
   end process;

end architecture;