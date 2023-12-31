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
end entity;
architecture rtl of Datapath is
   signal w_MAT_A_ROW, w_MAT_B_ROW                    : std_logic_vector(1 downto 0);
   signal w_ELE_A, w_ELE_B                            : std_logic_vector(p_WIDTH * p_ROWS - 1 downto 0);
   signal w_ELE_A0, w_ELE_A1, w_ELE_A2                : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_ELE_B0, w_ELE_B1, w_ELE_B2                : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_MULT_tmp_A0, w_MULT_tmp_A1, w_MULT_tmp_A2 : std_logic_vector(15 downto 0);
   signal w_MULT_A0, w_MULT_A1, w_MULT_A2             : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_ADDERS_OUT                                : std_logic_vector(p_WIDTH - 1 downto 0);
   signal w_MAT_B_TRANSPOSED                          : std_logic_vector(p_ROWS * p_COLS * p_WIDTH - 1 downto 0);
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
         i_D        : in std_logic_vector(p_WIDTH * p_ROWS * p_COLS - 1 downto 0);
         o_Q        : out std_logic_vector(p_WIDTH * p_COLS - 1 downto 0)
      );
   end component;
   component MatrixRegisterSingle is
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
         i_D        : in std_logic_vector(p_WIDTH - 1 downto 0);
         o_Q        : out std_logic_vector(p_WIDTH * p_ROWS * p_COLS - 1 downto 0)
      );
   end component;
   component MatrixTranspose is
      port (
         i_MAT            : in std_logic_vector(71 downto 0);
         o_MAT_TRANSPOSED : out std_logic_vector(71 downto 0)
      );
   end component;
   component RoundCounter is port (
      i_CLK                 : in std_logic;
      i_RST                 : in std_logic;
      i_ENABLE_COUNTER      : in std_logic;
      o_FINISHED_ALL_ROUNDS : out std_logic;
      o_COUNT_A             : out std_logic_vector := "00";
      o_COUNT_B             : out std_logic_vector := "00"
      );
   end component;
begin
   u_RoundCounter : RoundCounter port map(
      i_CLK                 => i_CLK,
      i_RST                 => i_RST, -- TODO: uncouple this
      i_ENABLE_COUNTER      => i_ENABLE_MAT_COUNTER,
      o_FINISHED_ALL_ROUNDS => o_FINISHED_ALL_ROUNDS,
      o_COUNT_A             => w_MAT_A_ROW,
      o_COUNT_B             => w_MAT_B_ROW
   );

   --
   w_ELE_A0 <= w_ELE_A(23 downto 16);
   w_ELE_A1 <= w_ELE_A(15 downto 8);
   w_ELE_A2 <= w_ELE_A(7 downto 0);
   --
   w_ELE_B0 <= w_ELE_B(23 downto 16);
   w_ELE_B1 <= w_ELE_B(15 downto 8);
   w_ELE_B2 <= w_ELE_B(7 downto 0);
   u_MAT_A : MatrixRegister
   generic map(
      p_WIDTH => p_WIDTH,
      p_COLS  => p_COLS,
      p_ROWS  => p_ROWS
   )
   port map(
      i_CLK      => i_CLK,
      i_RST      => i_RST,
      i_ADDR_ROW => w_MAT_A_ROW,
      i_D        => i_MAT_A,
      o_Q        => w_ELE_A
   );
   u_Transpose_MAT : MatrixTranspose
   port map(
      i_MAT            => i_MAT_B,
      o_MAT_TRANSPOSED => w_MAT_B_TRANSPOSED
   );
   u_MAT_B : MatrixRegister
   generic map(
      p_WIDTH => p_WIDTH,
      p_COLS  => p_COLS,
      p_ROWS  => p_ROWS
   )
   port map(
      i_CLK      => i_CLK,
      i_RST      => i_RST,
      i_ADDR_ROW => w_MAT_B_ROW,
      i_D        => w_MAT_B_TRANSPOSED,
      o_Q        => w_ELE_B
   );
   w_MULT_tmp_A0 <= std_logic_vector(unsigned(w_ELE_A0) * unsigned(w_ELE_B0));
   w_MULT_tmp_A1 <= std_logic_vector(unsigned(w_ELE_A1) * unsigned(w_ELE_B1));
   w_MULT_tmp_A2 <= std_logic_vector(unsigned(w_ELE_A2) * unsigned(w_ELE_B2));
   w_MULT_A0     <= w_MULT_tmp_A0(7 downto 0);
   w_MULT_A1     <= w_MULT_tmp_A1(7 downto 0);
   w_MULT_A2     <= w_MULT_tmp_A2(7 downto 0);

   w_ADDERS_OUT <= std_logic_vector(unsigned(w_MULT_A0) + unsigned(w_MULT_A1) + unsigned(w_MULT_A2));

   u_MAT_C : MatrixRegisterSingle
   generic map(
      p_WIDTH => p_WIDTH,
      p_COLS  => p_COLS,
      p_ROWS  => p_ROWS
   )
   port map(
      i_CLK      => i_CLK,
      i_RST      => i_RST,
      i_ADDR_ROW => w_MAT_A_ROW,
      i_ADDR_COL => w_MAT_B_ROW,
      i_D        => w_ADDERS_OUT,
      o_Q        => o_MAT_C
   );
end architecture;