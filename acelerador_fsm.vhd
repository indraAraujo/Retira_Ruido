library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity acelerador_fsm is
	port(
            -- entradas do processador para a FSM
            requisicao_comeco  : in std_logic;
            envio_tamanho      : in std_logic;
            envio_pixel        : in std_logic;
            fim_pixels         : in std_logic;
            ack_processador    : in std_logic;

            -- saídas da FSM para o processador 
            permissao_comeco   : out std_logic;
            ack_acelerador     : out std_logic;
            envio_mediana      : out std_logic;
            
            -- saída da FSM para o acelerador
            calcular           : out std_logic;
            ack_pixelEnviado   : out std_logic
		);
end entity;

architecture behavior of acelerador_fsm is
type state_name is (zero, first, second, third, fourth); -- nome dos estados
signal state, next_state : state_name;  -- tipo de dado dos estados
begin

-- processo sequencial 
process(requisicao_comeco, envio_tamanho, envio_pixel, fim_pixels, ack_processador)
begin
	state <= next_state;
end process;

-- processo combinacional da saida da FSM
process (state)
begin
	case state is
		when zero =>
            permissao_comeco <= '0'; 
            ack_acelerador   <= '0';   
            envio_mediana    <= '0'; 
            calcular         <= '0'; 
		when first =>
            permissao_comeco <= '1'; 
            ack_acelerador   <= '0';   
            envio_mediana    <= '0'; 
            calcular         <= '0'; 
		when second =>
            permissao_comeco <= '0'; 
            ack_acelerador   <= '1';   
            envio_mediana    <= '0'; 
            calcular         <= '0'; 
		when third =>
            permissao_comeco <= '0'; 
            ack_acelerador   <= '1';   
            envio_mediana    <= '0'; 
            calcular         <= '1'; 
            ack_pixelEnviado <= '1';
        when fourth =>
            permissao_comeco <= '0'; 
            ack_acelerador   <= '0';   
            envio_mediana    <= '1'; 
            calcular         <= '0'; 
		end case;
end process;

-- processo combinacional da saida da FSM
process (state)
begin
	case state is
		when zero =>
			next_state <= first;
		when first =>
		    next_state <= second;
		when second =>
		    next_state <= third;
		when third =>
            next_state <= fourth;
		--end case;
            when fourth =>
            next_state <= zero;
		end case;
end process;

end behavior;
	