library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MatrixRegisterSingle is
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
end entity;
architecture rtl of MatrixRegisterSingle is
   type matrix_t is array (0 to 2, 0 to 2) of std_logic_vector(7 downto 0);
   signal matrix : matrix_t := (others => (others => "00000000"));
begin
   process (i_CLK, i_RST, i_ADDR_ROW, i_ADDR_COL, matrix)
   begin
      if i_RST = '1' then
         matrix <= (others => (others => "00000000"));
      elsif
         rising_edge(i_CLK) then
         matrix(to_integer(unsigned(i_ADDR_ROW)),
         to_integer(unsigned(i_ADDR_COL)))
         <= i_D;
      end if;
      o_Q <= matrix(0, 0) & matrix(0, 1) & matrix(0, 2) &
         matrix(1, 0) & matrix(1, 1) & matrix(1, 2) &
         matrix(2, 0) & matrix(2, 1) & matrix(2, 2);
   end process;

end architecture;