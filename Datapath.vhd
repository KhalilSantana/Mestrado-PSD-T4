library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Datapath is
   generic (
      p_WIDTH : integer := 8;
      p_ROWS  : integer := 3;
      p_COLS  : integer := 3
   );
   port (
      i_CLK                              : in std_logic;
      i_RST                              : in std_logic;
      i_RST_ACC                          : in std_logic;
      i_MAT_A                            : in std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
      i_MAT_B                            : in std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
      i_MAT_A_ADDR_ROW, i_MAT_A_ADDR_COL : in std_logic_vector(1 downto 0);
      i_MAT_B_ADDR_ROW, i_MAT_B_ADDR_COL : in std_logic_vector(1 downto 0);
      o_MAT_C                            : out std_logic_vector(p_WIDTH - 1 downto 0)
   );
end entity;
architecture rtl of Datapath is
   signal w_ELE_A, w_ELE_B    : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_MULT_temp         : std_logic_vector(15 downto 0);
   signal w_Acc_in, w_Acc_out : std_logic_vector(p_WIDTH - 1 downto 0);
   component MatrixRegister is
      generic (
         p_WIDTH : integer := 8;
         p_ROWS  : integer := 3;
         p_COLS  : integer := 3
      );
      port (
         i_CLK      : in std_logic;
         i_RST      : in std_logic;
         i_ADDR_ROW : in std_logic_vector(1 downto 0);
         i_ADDR_COL : in std_logic_vector(1 downto 0);
         i_D        : in std_logic_vector(p_WIDTH * p_ROWS * p_COLS - 1 downto 0);
         o_Q        : out std_logic_vector(p_WIDTH - 1 downto 0)
      );
   end component;
   component Accumulator is
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
   end component;
begin
   u_MAT_A : MatrixRegister port map(
      i_CLK      => i_CLK,
      i_RST      => i_RST,
      i_ADDR_ROW => i_MAT_A_ADDR_ROW,
      i_ADDR_COL => i_MAT_A_ADDR_COL,
      i_D        => i_MAT_A,
      o_Q        => w_ELE_A
   );

   u_MAT_B : MatrixRegister port map(
      i_CLK      => i_CLK,
      i_RST      => i_RST,
      i_ADDR_ROW => i_MAT_B_ADDR_ROW,
      i_ADDR_COL => i_MAT_B_ADDR_COL,
      i_D        => i_MAT_B,
      o_Q        => w_ELE_B
   );
   u_Acc : Accumulator port map(
      i_CLK => i_CLK,
      i_RST => i_RST_ACC,
      i_D   => w_Acc_in,
      o_Q   => w_Acc_out
   );
   w_MULT_temp <= std_logic_vector(unsigned(w_ELE_A) * unsigned(w_ELE_B));
   w_Acc_in    <= w_MULT_temp(p_WIDTH - 1 downto 0);
   o_MAT_C     <= w_Acc_out;
end architecture;