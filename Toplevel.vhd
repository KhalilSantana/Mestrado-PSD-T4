library ieee;
use ieee.std_logic_1164.all;

entity Toplevel is
   generic (
      p_WIDTH : integer := 8;
      p_ROWS  : integer := 3;
      p_COLS  : integer := 3
   );
   port (
      -- Control pins
      i_CLK : in std_logic;
      i_RST : in std_logic;
      o_RDY : out std_logic;
      -- Data pins
      i_MAT_A : in std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
      i_MAT_B : in std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
      o_MAT_C : out std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0)
   );
end entity;
architecture rtl of Toplevel is
   signal w_MAT_A_ADDR_ROW      : std_logic_vector(1 downto 0);
   signal w_MAT_B_ADDR_ROW      : std_logic_vector(1 downto 0);
   signal w_ENABLE_MAT_COUNTER  : std_logic;
   signal w_FINISHED_ALL_ROUNDS : std_logic;

   component Controller is
      port (
         i_CLK : in std_logic;
         i_RST : in std_logic;
         --
         i_FINISHED_ALL_ROUNDS : in std_logic;
         o_ENABLE_MAT_COUNTER  : out std_logic := '0';
         o_RDY                 : out std_logic
      );
   end component;
   component Datapath is
      generic (
         p_WIDTH : integer := 8;
         p_ROWS  : integer := 3;
         p_COLS  : integer := 3
      );
      port (
         -- Control pins
         i_CLK                 : in std_logic;
         i_RST                 : in std_logic;
         i_ENABLE_MAT_COUNTER  : in std_logic;
         o_FINISHED_ALL_ROUNDS : out std_logic;
         -- Data pins
         i_MAT_A : in std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
         i_MAT_B : in std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
         o_MAT_C : out std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0)
      );
   end component;
begin
   u_Controller : Controller port map(
      i_CLK => i_CLK,
      i_RST => i_RST,
      o_RDY => o_RDY,
      --
      i_FINISHED_ALL_ROUNDS => w_FINISHED_ALL_ROUNDS,
      o_ENABLE_MAT_COUNTER  => w_ENABLE_MAT_COUNTER
   );
   u_Datapath : Datapath port map(
      i_CLK => i_CLK,
      i_RST => i_RST,
      --
      i_ENABLE_MAT_COUNTER  => w_ENABLE_MAT_COUNTER,
      o_FINISHED_ALL_ROUNDS => w_FINISHED_ALL_ROUNDS,
      -- Data pins
      i_MAT_A => i_MAT_A,
      i_MAT_B => i_MAT_B,
      o_MAT_C => o_MAT_C
   );
end architecture;