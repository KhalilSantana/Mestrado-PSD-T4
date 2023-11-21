library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MatrixRegister is
  generic (
    p_MATRIX_ELEMENT_SIZE : integer := 8;
    p_MATRIX_ROWS         : integer := 3;
    p_MATRIX_COLS         : integer := 3
  );
  port (
    i_CLK  : in std_logic;
    i_RST  : in std_logic;
    i_ADDR_ROW : in std_logic_vector(1 downto 0);
    i_ADDR_COL : in std_logic_vector(1 downto 0);
    i_D    : in std_logic_vector(p_MATRIX_ELEMENT_SIZE * 9-1 downto 0);
    o_Q    : out std_logic_vector(p_MATRIX_ELEMENT_SIZE-1 downto 0)
  );
end entity;
architecture rtl of MatrixRegister is
  type matrix_t is array (0 to 2, 0 to 2) of STD_LOGIC_VECTOR(7 downto 0);
  signal matrix : matrix_t;
begin
  process (i_CLK, i_RST, i_ADDR_ROW, i_ADDR_COL, matrix)
  begin
    if i_RST = '1' then
      matrix <= (others => (others => "00000000"));
    elsif
      rising_edge(i_CLK) then
        matrix(0,0) <= i_D(71 downto 64);
        matrix(0,1) <= i_D(63 downto 56);
        matrix(0,2) <= i_D(55 downto 48);
        ---ROW 2
        matrix(1,0) <= i_D(47 downto 40);
        matrix(1,1) <= i_D(39 downto 32);
        matrix(1,2) <= i_D(31 downto 24);
        ---ROW 3
        matrix(2,0) <= i_D(23 downto 16);
        matrix(2,1) <= i_D(15 downto 8);
        matrix(2,2) <= i_D(7 downto 0);
    end if;
    o_Q <= matrix(
      to_integer(unsigned(i_ADDR_ROW)),
      to_integer(unsigned(i_ADDR_COL)));
  end process;

end architecture;