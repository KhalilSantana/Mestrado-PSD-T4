library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity RoundCounter is port (
   i_CLK                 : in std_logic;
   i_RST                 : in std_logic; -- TODO: remove?
   i_ENABLE_COUNTER      : in std_logic;
   o_FINISHED_ALL_ROUNDS : out std_logic;
   o_COUNT_A             : out std_logic_vector (1 downto 0) := "00";
   o_COUNT_B             : out std_logic_vector (1 downto 0) := "00"
);
end entity;

architecture arch of RoundCounter is
   signal w_count_A : unsigned(1 downto 0) := "00";
   signal w_count_B : unsigned(1 downto 0) := "00";
begin
   process (i_CLK, i_RST, i_ENABLE_COUNTER)
   begin
      if i_RST = '1' then
         w_count_A             <= "00";
         w_count_B             <= "00";
         o_FINISHED_ALL_ROUNDS <= '0';
      elsif rising_edge(i_CLK) then
         if i_ENABLE_COUNTER = '1' then
            w_count_B <= w_count_B + 1;
            if w_count_B = 2 then
               w_count_A <= w_count_A + 1;
               w_count_B <= (others => '0');
               if w_count_A = 2 then
                  w_count_A             <= (others => '0');
                  o_FINISHED_ALL_ROUNDS <= '1';
               end if;
            end if;
         end if;
      end if;
   end process;
   o_COUNT_A <= std_logic_vector(w_count_A);
   o_COUNT_B <= std_logic_vector(w_count_B);
end arch;