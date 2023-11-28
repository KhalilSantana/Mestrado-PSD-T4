library ieee;
use ieee.std_logic_1164.all;

entity Controller is
   port (
      i_CLK : in std_logic;
      i_RST : in std_logic;
      --
      i_FINISHED_ALL_ROUNDS : in std_logic;
      o_ENABLE_MAT_COUNTER  : out std_logic := '0';
      o_RDY                 : out std_logic
   );
end entity;
architecture rtl of Controller is
   type t_STATE is (
      s_START,
      s_ELE_0, s_ELE_1, s_ELE_2,
      s_ELE_3, s_ELE_4, s_ELE_5,
      s_ELE_6, s_ELE_7, s_ELE_8,
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
   process (r_STATE)
   begin
      case r_STATE is
         when s_START => w_NEXT <= s_ELE_0;
            --
         when s_ELE_0 => w_NEXT <= s_ELE_1;
         when s_ELE_1 => w_NEXT <= s_ELE_2;
         when s_ELE_2 => w_NEXT <= s_ELE_3;
            --
         when s_ELE_3 => w_NEXT <= s_ELE_4;
         when s_ELE_4 => w_NEXT <= s_ELE_5;
         when s_ELE_5 => w_NEXT <= s_ELE_6;
            --
         when s_ELE_6 => w_NEXT <= s_ELE_7;
         when s_ELE_7 => w_NEXT <= s_ELE_8;
         when s_ELE_8 => w_NEXT <= s_END;
            --
         when s_END  => w_NEXT  <= s_START;
         when others => w_NEXT <= s_START;
      end case;
   end process;
   -- Output Function
   o_ENABLE_MAT_COUNTER <=
      '0' when (r_STATE = s_START) or (r_STATE = s_END) else
      '1';
   o_RDY <= i_FINISHED_ALL_ROUNDS;
end architecture;