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
      i_MAT_A                            : in std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
      i_MAT_B                            : in std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
      i_MAT_A_ADDR_ROW, i_MAT_A_ADDR_COL : in std_logic_vector(1 downto 0);
      i_MAT_B_ADDR_ROW, i_MAT_B_ADDR_COL : in std_logic_vector(1 downto 0);
      o_MAT_C                            : out std_logic_vector(p_WIDTH - 1 downto 0)
   );
end entity;
architecture rtl of Datapath is
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
   signal wo_MAT_A, wo_MAT_B : std_logic_vector(p_WIDTH - 1 downto 0) := (others => '1');
   signal wo_MULT, wo_ACC    : std_logic_vector(p_WIDTH - 1 downto 0) := (others => '1');
   signal wo_MULT_tmp        : std_logic_vector(p_WIDTH * 2 - 1 downto 0);
   -- signal w_MAT_C_ADDR_ROW, w_MAT_C_ADDR_COL : std_logic_vector(1 downto 0) := (others => '0');

begin
   u_MAT_A : MatrixRegister
   port map(
      i_CLK      => i_CLK,
      i_RST      => i_RST,
      i_D        => i_MAT_A,
      o_Q        => wo_MAT_A,
      i_ADDR_ROW => i_MAT_A_ADDR_ROW,
      i_ADDR_COL => i_MAT_A_ADDR_COL
   );

   u_MAT_B : MatrixRegister
   port map(
      i_CLK      => i_CLK,
      i_RST      => i_RST,
      i_D        => i_MAT_B,
      o_Q        => wo_MAT_B,
      i_ADDR_ROW => i_MAT_B_ADDR_ROW,
      i_ADDR_COL => i_MAT_B_ADDR_COL
   );

   -- u_MAT_C : MatrixRegister
   -- port map(
   --    i_CLK      => i_CLK,
   --    i_RST      => i_RST,
   --    i_D        => wi_MAT_C,
   --    o_Q        => wo_MAT_C,
   --    i_ADDR_ROW => w_MAT_C_ADDR_ROW,
   --    i_ADDR_COL => w_MAT_C_ADDR_COL
   -- );

   u_ACC : Accumulator port map(
      i_CLK => i_CLK,
      i_RST => i_RST,
      i_D   => wo_MULT,
      o_Q   => wo_ACC
   );

   wo_MULT_tmp <= std_logic_vector(unsigned(wo_MAT_A) * unsigned(wo_MAT_B));
   wo_MULT     <= wo_MULT_tmp(p_WIDTH - 1 downto 0);
   o_MAT_C     <= wo_ACC;

   end architecture;