library ieee;
use ieee.std_logic_1164.all;

entity Controller_tb is
end entity Controller_tb;

architecture tb of Controller_tb is
   signal w_CLK, w_RST                   : std_logic := '0';
   signal RDY                            : std_logic;
   signal MAT_A_ADDR_ROW, MAT_B_ADDR_ROW : std_logic_vector(1 downto 0);
begin
   -- Instantiate the Controller
   u_Controller : entity work.Controller
      port map(
         i_CLK            => w_CLK,
         i_RST            => w_RST,
         o_RDY            => RDY
      );

   -- Clock process
   process (w_CLK)
   begin
      w_CLK <= not w_CLK after 1 ps;
   end process;

   -- Stimulus process
   process
   begin
      wait for 100 ps;

   end process;
end architecture tb;