library ieee;
use ieee.std_logic_1164.all;

entity Controller is
   port (
      i_CLK : in std_logic;
      i_RST : in std_logic;
      --
      i_START               : in std_logic;
      i_FINISHED_ALL_ROUNDS : in std_logic;
      o_ENABLE_MAT_COUNTER  : out std_logic := '0';
      o_RDY                 : out std_logic := '0'
   );
end entity;
architecture rtl of Controller is
   type t_STATE is (
      s_START,
      s_RUNNING,
      s_END
   );
   signal w_NEXT  : t_STATE; -- next state
   signal r_STATE : t_STATE; -- current state
begin
   -- State Register
   process (i_RST, i_CLK)
   begin
      if (i_RST = '1') then
         r_STATE <= s_START;
      elsif (rising_edge(i_CLK)) then
         r_STATE <= w_NEXT;
      end if;
   end process;
   -- Next State Function
   process (r_STATE, i_START, i_FINISHED_ALL_ROUNDS, i_RST)
   begin
      case r_STATE is
         when s_START =>
            if i_START = '1' then
               w_NEXT <= s_RUNNING;
            else
               w_NEXT <= s_START;
            end if;
            --
         when s_RUNNING =>
            if i_FINISHED_ALL_ROUNDS = '1' then
               w_NEXT <= s_END;
            else
               w_NEXT <= s_RUNNING;
            end if;
            --
         when s_END =>
            if i_RST = '1' then
               w_NEXT      <= s_START;
            else w_NEXT <= s_END;
            end if;
         when others => w_NEXT <= s_START;
      end case;
   end process;
   -- Output Function
   o_ENABLE_MAT_COUNTER <=
      '0' when (r_STATE = s_START) or (r_STATE = s_END) else
      '1';
   o_RDY <=
      '1' when (r_STATE = s_END) else
      '0';
end architecture;