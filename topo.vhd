library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity topo is
    port(
         requisicao_comeco_topo  : in std_logic;
         envio_tamanho_topo       : in std_logic;
         envio_pixel_topo        : in std_logic;
         fim_pixels_topo          : in std_logic;
         ack_processador_topo     : in std_logic;
         pixel_topo                  : in std_logic_vector(7 downto 0);
         enable_tamanho_topo: in std_logic_vector(1 downto 0);
         mediana_topo       : out std_logic_vector(7 downto 0); 
         pronto_topo        : out std_logic ;
         permissao_comeco   : out std_logic;
         envio_mediana      : out std_logic;
    );
end entity;
architecture behavior of topo is

component acelerador_fsm is
	port(
         requisicao_comeco  : in std_logic;
         envio_tamanho      : in std_logic;
         envio_pixel        : in std_logic;
         fim_pixels         : in std_logic;
         ack_processador    : in std_logic;
         permissao_comeco   : out std_logic;
         ack_acelerador     : out std_logic;
         envio_mediana      : out std_logic;
         calcular           : out std_logic;
        ack_pixelEnviado    : out std_logic
	);
end component;

component acelerador is
	port(
        enable_tamanho      : in std_logic_vector(1 downto 0);
        clock               : in std_logic;
        ack_pixelEnviado    : in std_logic; 
        pixel               : in std_logic_vector(7 downto 0);
        calcular            : in std_logic;                  
        mediana             : out std_logic_vector(7 downto 0);
        pronto              : out std_logic                  
		);
end component;

signal calcular_topo: std_logic;
signal ack_pixelEnviado_topo: std_logic;

begin
    inst_fsm: acelerador_fsm port map(
		requisicao_comeco   => requisicao_comeco_topo  ,
         envio_tamanho      =>  envio_tamanho_topo  ,
         envio_pixel        =>  envio_pixel_topo  ,
         fim_pixels         =>  fim_pixels_topo  ,
         ack_processador    =>  ack_processador_topo  ,
         permissao_comeco   =>  permissao_comeco_topo ,
         ack_acelerador     =>  ack_acelerador_topo ,
         envio_mediana      =>  envio_mediana_topo ,
         calcular           =>  calcular_topo ,
        ack_pixelEnviado    => ack_pixelEnviado_topo 
    );

    inst_acelerador: acelerador port map(
        enable_tamanho   <= enable_tamanho_topo,  
        clock            <= clock_topo, 
        ack_pixelEnviado <= ack_pixelEnviad_topo, 
        pixel            <= pixel_topo, 
        calcular         <= calcular_topo, 
        mediana          <= mediana_topo, 
        pronto           <= pronto_topo
        );

end behavior;
	