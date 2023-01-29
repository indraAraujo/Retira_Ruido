library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use ieee.std_logic_arith.all;
use ieee.std_logic_arith.UNSIGNED;

use ieee.numeric_std.all;
use ieee.NUMERIC_STD.UNSIGNED;

entity acelerador is
	port(
            tamanho       : in std_logic_vector(3 downto 0); 
            pixel         : in std_logic_vector(7 downto 0); 
            calcular      : in std_logic;
            mediana       : out std_logic_vector(7 downto 0)
		);
end entity;

architecture behavior of acelerador is

type vetor is array (0 to 8) of std_logic_vector(7 downto 0);
signal vetor_nao_ordenado : vetor;
signal vetor_ordenado : vetor;

signal temporario : std_logic_vector(7 downto 0);
signal pivo : std.STANDARD.INTEGER := 1;

signal terminado : std_logic := '0';
signal mediana_temporaria : std_logic_vector(7 downto 0) := "00000000"; 

signal contador : std.STANDARD.INTEGER := 0;--por algum motivo o contador ta começando com 1 mesmo declarando como 0

begin
    process(pixel)
    begin
        vetor_nao_ordenado(contador) <= pixel;
        contador <= contador + 1;
        if(contador > 8) then
            contador <= 0;
        end if;
    end process;

    

    process(calcular)
        begin
            --vetor_ordenado <= vetor_nao_ordenado;-- o vetor odenado NÃO está recebendo os valores
            vetor_ordenado(0) <= vetor_nao_ordenado(0);
            vetor_ordenado(1) <= vetor_nao_ordenado(1);
            vetor_ordenado(2) <= vetor_nao_ordenado(2);
            vetor_ordenado(3) <= vetor_nao_ordenado(3);
            vetor_ordenado(4) <= vetor_nao_ordenado(4);
            vetor_ordenado(5) <= vetor_nao_ordenado(5);
            vetor_ordenado(6) <= vetor_nao_ordenado(6);
            vetor_ordenado(7) <= vetor_nao_ordenado(7);
            vetor_ordenado(8) <= vetor_nao_ordenado(8);
            
            --if(contador > 2) then -- precisa ter pelo menos dois itens no vetor, pra poder comparar
            
            if (calcular = '1') then
            while (pivo+1) < tamanho loop -- +1 pq o pivo n pode comparar com mais do q o index do vetor

                if(vetor_ordenado(pivo) > vetor_ordenado(pivo+1)) then
                    temporario <= vetor_ordenado(pivo);
                    vetor_ordenado(pivo) <= vetor_ordenado(pivo+1);
                    vetor_ordenado(pivo+1) <= temporario;
                    pivo<=1;
                else 
                    pivo <= pivo+1;
                end if;

            end loop;
            end if;

    end process;

    process(pivo, tamanho)
        begin
        if(pivo=tamanho) then
            --mediana_temporaria <= vetor_ordenado(4);--(vetor((to_integer(tamanho) / 2))+vetor((to_integer(tamanho)/2)-1))/2;
            terminado<='1';
        end if;
    end process;
    
    process(calcular, terminado)
        begin
            if(calcular='1' AND terminado='1') then
                mediana <= vetor_ordenado(5);--mediana_temporaria;
            end if;
        end process;
end behavior;
	