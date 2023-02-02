library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use ieee.numeric_std.all;
use ieee.NUMERIC_STD.unsigned;

use ieee.std_logic_arith.all;
use ieee.std_logic_arith.unsigned;



entity acelerador is
	port(
            enable_tamanho: in std_logic_vector(1 downto 0);--seleciona o bloco de codigo que deve funcionar 
                                                            --(01) = 3x3
                                                            --(10) = 5x5
                                                            --(11) = 9x9

            clock               : in std_logic;
            ack_pixelEnviado    : in std_logic;    -- Informa que há um novo pixel pronto

            pixel         : in std_logic_vector(7 downto 0);--recebe o pixel do softw.(8 bits = 256) 
            calcular      : in std_logic;                   --informa que todos os bits já foram enviados e pode iniciar o calculo
            mediana       : out std_logic_vector(7 downto 0);--retorna a mediana
            pronto        : out std_logic
		);
end entity;

architecture behavior of acelerador is

type vetor is array (0 to 8) of std_logic_vector(7 downto 0);
signal vetor_nao_ordenado : vetor;                 -- Recebe todos os pixel
signal vetor_ordenado     : vetor;                 -- Recebe os pixel na ordem certa

signal vet_aux_1 : std_logic_vector(7 downto 0);   -- Usado para ordenar o vetor
signal vet_aux_2 : std_logic_vector(7 downto 0);   -- Usado para ordenar o vetor

signal pivo     : std.STANDARD.INTEGER := 0;            -- Usado para ordenar o vetor
signal pivo_2   : std.STANDARD.INTEGER := 0;            -- Usado para ordenar o vetor
signal contador : std.STANDARD.INTEGER := 0;        -- Index para receber os pixels
signal troca    : std_logic := '0';                 -- Usado para identificar trocas no vetor

signal terminado : std_logic := '0';                -- Informa que o vetor já está ordenado

-- Usado para indexar o vetor
signal tam_aux          : std.STANDARD.INTEGER := 0;

-- Indexa a posição mediana do vetor
signal mediana_posic    : std.STANDARD.INTEGER := 0;

-- Variaveis de debug:
--signal print : std.STANDARD.INTEGER := 0;

begin
    -- Controle de tamanho do quadro
    process(enable_tamanho)
    begin
        pronto <= '0';
        if(enable_tamanho = "00") then
            tam_aux <= 9;--3x3
            mediana_posic <= 4;--(tamanho*tamanho)/2); 3x3 = 9/2 = 4
        elsif(enable_tamanho = "10") then
            tam_aux <= 25;--5x5
            mediana_posic <= 12;--(tamanho*tamanho)/2); 5x5 = 25/2 = 12
        elsif(enable_tamanho = "11") then
            tam_aux <= 81;--9x9
            mediana_posic <= 40;--(tamanho*tamanho)/2); 9x9 = 81/2 = 40
        end if;
    end process;
    -- Fim controle de tamanho

    -- Recebe os pixels:
    process(ack_pixelEnviado,troca)--clock)
    begin
        --if rising_edge(clock) then
            if(ack_pixelEnviado='1') then
                if(pixel /= "UUUUUUUU") then
                    vetor_nao_ordenado(contador) <= pixel;
                    contador <= contador + 1;
                    if(contador >= 8) then
                        contador <= 0;
                    end if;
                end if;
            elsif(troca = '1') then 
                vetor_nao_ordenado(pivo_2) <= vet_aux_2;
                vetor_nao_ordenado(pivo_2+1) <= vet_aux_1;
            end if;
    --end if;
    end process;
    -- Fim de Recebe pixels;

    -- Ordena o vetor:
    process(clock)
    begin
        if(rising_edge(clock) and calcular='1') then
            troca <= '0';
            --print <= print + 1;
            if(pivo < tam_aux-1) then
                if(vetor_nao_ordenado(pivo) > vetor_nao_ordenado(pivo+1)) then-- Se o 1° > 2° troca a posição
                    troca <= '1';
                    pivo_2 <= pivo;
                    pivo <= 0;
                else                                                           -- Se não, mantém
                    vetor_ordenado(pivo) <= vet_aux_1;
                    vetor_ordenado(pivo+1) <= vet_aux_2;
                    pivo <= pivo + 1;  
                end if;
            else
                terminado <= '1';
            end if;

        end if;
    end process;

    process(pivo,calcular) --Coloca o proximo pixel num vetor auxiliar
    begin
        if(pivo < 8) then
            vet_aux_1 <= vetor_nao_ordenado(pivo);
            vet_aux_2 <= vetor_nao_ordenado(pivo+1);
        end if;
    end process;
    -- Fim de Ordena vetor;

-- Envia a mediana
    process(clock)
    begin
        if(rising_edge(clock) and terminado='1') then
            mediana <= vetor_ordenado(mediana_posic);
            pronto <= terminado;
        end if;
    end process;
 -- Fim envia mediana

end behavior;
	