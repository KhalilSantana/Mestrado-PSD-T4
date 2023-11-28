library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity RoundCounter is port (
   i_CLK            : in std_logic;
   i_RST            : in std_logic; -- TODO: remove?
   i_ENABLE_COUNTER : in std_logic;
   o_COUNT          : out std_logic_vector := "00"
);
end entity;

architecture arch of RoundCounter is
   signal w_count : unsigned(1 downto 0) := "00";
begin
   process (i_CLK, i_RST, i_ENABLE_COUNTER)
   begin
      if rising_edge(i_CLK) then
         if w_count = 2 and i_ENABLE_COUNTER = '1' then
            w_count <= "00";
         else
            if i_ENABLE_COUNTER = '1' then
               w_count <= w_count + 1;
            end if;
         end if;
      end if;
   end process;
   o_COUNT <= std_logic_vector(w_count);
end arch;