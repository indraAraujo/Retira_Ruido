-- Quartus II VHDL Template
-- Basic Shift Register

library ieee;
use ieee.std_logic_1164.all;

entity Intro is

	port 
	(
		osc_clk		: in std_logic;
		reset_n     : in std_logic;
		led         : out std_logic_vector(3 downto 0);
		button      : in std_logic_vector(3 downto 0)
	);

end entity;

architecture rtl of Intro is

signal x_conn         : std_logic_vector(29 downto 0);     --         x.export
signal dadoprt_conn   : std_logic;                         --   dadoprt.export
signal sqrtx_conn     : std_logic_vector(29 downto 0); 	 --     sqrtx.export
signal go_conn        : std_logic;                         --        go.export
signal resetproc_conn : std_logic;                         --  resetproc.export

component MyFirstSOC is
	port (
		clk_clk          : in  std_logic                     := '0';             --       clk.clk
		reset_reset_n    : in  std_logic                     := '0';             --     reset.reset_n
		leds_export      : out std_logic_vector(3 downto 0);                     --      leds.export
		buttons_export   : in  std_logic_vector(3 downto 0)  := (others => '0'); --   buttons.export
		x_export         : out std_logic_vector(29 downto 0);                    --         x.export
		dadoprt_export   : in  std_logic                     := '0';             --   dadoprt.export
		sqrtx_export     : in  std_logic_vector(29 downto 0) := (others => '0'); --     sqrtx.export
		go_export        : out std_logic;                                        --        go.export
		resetproc_export : out std_logic                                         -- resetproc.export
	);
end component MyFirstSOC;

component Sqrt_top is

	generic
	(
		DATA_WIDTH_TOP : natural := 4
	);
	
	port 
	(
		clk_top   : in std_logic;
		reset_top : in std_logic;
		go_top    : in std_logic;
		x_top	  : in std_logic_vector ((DATA_WIDTH_TOP-1) downto 0);
		t_out_top : out std_logic;
		sqrtx : out std_logic_vector ((DATA_WIDTH_TOP-1) downto 0);
		dadoPrt_top: out std_logic
	);

end component;

	
begin

MySoC: MyFirstSOC port map (

		clk_clk        => osc_clk,
		reset_reset_n  => reset_n,
		leds_export    => led,
		buttons_export => button,
		x_export       => x_conn,
		dadoprt_export => dadoprt_conn,
		sqrtx_export   => sqrtx_conn,
		go_export      => go_conn,
		resetproc_export => resetproc_conn
	);
	
SQRT: Sqrt_top generic map (DATA_WIDTH_TOP => 30)
		port map(
		clk_top     => osc_clk,
		reset_top   => resetproc_conn,
		go_top      => go_conn,
		x_top	      => x_conn,
		sqrtx       => sqrtx_conn,
		dadoPrt_top => dadoprt_conn
		);
      
end rtl;
