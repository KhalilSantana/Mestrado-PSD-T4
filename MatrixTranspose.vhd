library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MatrixTranspose is
   port (
      i_MAT            : in std_logic_vector(71 downto 0);
      o_MAT_TRANSPOSED : out std_logic_vector(71 downto 0)
   );
end entity;

architecture rtl of MatrixTranspose is
   signal row0col0, row0col1, row0col2 : std_logic_vector(7 downto 0);
   signal row1col0, row1col1, row1col2 : std_logic_vector(7 downto 0);
   signal row2col0, row2col1, row2col2 : std_logic_vector(7 downto 0);
begin
   -- Transpose the matrix
   row0col0 <= i_MAT(71 downto 64);
   row0col1 <= i_MAT(63 downto 56);
   row0col2 <= i_MAT(55 downto 48);
   --
   row1col0 <= i_MAT(47 downto 40);
   row1col1 <= i_MAT(39 downto 32);
   row1col2 <= i_MAT(31 downto 24);
   --
   row2col0 <= i_MAT(23 downto 16);
   row2col1 <= i_MAT(15 downto 8);
   row2col2 <= i_MAT(7 downto 0);

   -- Form the transposed matrix
   o_MAT_TRANSPOSED <= 
   row0col0 & row1col0 & row2col0 &
   row0col1 & row1col1 & row2col1 &
   row0col2 & row1col2 & row2col2;

end architecture rtl;