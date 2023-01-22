library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity topo is
    port(
        -- entradas do processador para a FSM
        requisicao_comeco_topo  : in std_logic;
        envio_tamanho_topo      : in std_logic;
        envio_pixel_topo        : in std_logic;
        fim_pixels_topo         : in std_logic;
        ack_processador_topo    : in std_logic;

        -- entradas do processador para o acelerador
        tamanho_topo            : in std_logic_vector(2 downto 0); 
        pixel_topo              : in std_logic; -- !TODO: QUAL O TAMANHO DO PIXEL??

        -- saídas da FSM para o processador 
        permissao_comeco_topo   : out std_logic;
        ack_acelerador_topo     : out std_logic;
        envio_mediana_topo      : out std_logic;

        -- saída do acelerador para o processador
        mediana_topo            : out std_logic(2 downto 0)  -- !TODO: QUAL O  TAMANHO DA MEDIANA ??
    );
end entity;
architecture behavior of topo is

component fsm is
	port(
        requisicao_comeco  : in std_logic;
        envio_tamanho      : in std_logic;
        envio_pixel        : in std_logic;
        fim_pixels         : in std_logic;
        ack_processador    : in std_logic;
        permissao_comeco   : out std_logic;
        ack_acelerador     : out std_logic;
        envio_mediana      : out std_logic;
        calcular           : out std_logic
	);
end component;

component acelerador is
	port(
		
		);
end component;

signal calcular_topo: std_logic;

begin

inst_fsm: fsm
	port map( 
            requisicao_comeco  => requisicao_comeco_topo,
            envio_tamanho      => envio_tamanho_topo,    
            envio_pixel        => envio_pixel_topo,       
            fim_pixels         => fim_pixels_topo,        
            ack_processador    => ack_processador_topo,  
            permissao_comeco   => permissao_comeco_topo,  
            ack_acelerador     => ack_acelerador_topo,    
            envio_mediana      => envio_mediana_topo,     
            calcular           => calcular_topo,         
        );

inst_acelerador: acelerador
   port map (
            
            );
end behavior;
	