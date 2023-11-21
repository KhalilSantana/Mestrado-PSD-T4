library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ElementSelector is
  generic (
    p_WIDTH       : integer := 8;
    p_MATRIX_ROWS : integer := 3;
    p_MATRIX_COLS : integer := 3;
    N             : integer := 9 -- Set the number of elements in the vector
  );
  port (
    i_ADDR : in std_logic_vector(3 downto 0); -- Address width based on the number of elements
    o_Q    : out std_logic_vector(p_WIDTH - 1 downto 0);
    i_D    : in std_logic_vector(p_WIDTH * N - 1 downto 0)
  );
end ElementSelector;

architecture Behavioral of ElementSelector is
begin
  o_Q <= i_D(to_integer(unsigned(i_ADDR) * p_WIDTH - 1) downto to_integer(unsigned(i_ADDR) * p_WIDTH - 1 - p_WIDTH));
end Behavioral;
-- E=A*W downto A*W-a-w
-- E=2*2 downto 2*2-2-0
-- 10 |20| 30
-- 40 50 60
-- 70 80 90