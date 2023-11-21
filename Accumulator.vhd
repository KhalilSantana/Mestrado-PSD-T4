library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Accumulator is
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
end entity;
architecture rtl of Accumulator is
   signal w_ACC : std_logic_vector(p_WIDTH-1 downto 0);
begin
   process (i_CLK, i_RST, w_ACC)
   begin
      if i_RST = '1' then
         w_ACC <= (others => '0');
      elsif
         rising_edge(i_CLK) then
            w_ACC <= std_logic_vector(unsigned(w_ACC) + unsigned(i_D));
         end if;
      o_Q <= w_ACC;
   end process;

end architecture;