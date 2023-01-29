library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use std_logic_signed.all;

use ieee.numeric_std.all;
use ieee.NUMERIC_STD.unsigned;

use ieee.std_logic_arith.all;
use ieee.std_logic_arith.unsigned;



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
--signal vetor_nao_ordenado : vetor;
signal vetor_ordenado : vetor;

signal temporario : std_logic_vector(7 downto 0);
signal pivo : std.STANDARD.INTEGER := 0;

signal terminado : std_logic := '0';
signal mediana_temporaria : std_logic_vector(7 downto 0) := "00000000";

signal pivo_aux : std_logic_vector(3 downto 0);
signal tam_aux  : std.STANDARD.INTEGER := 0;

signal contador : std.STANDARD.INTEGER := 0;--por algum motivo o contador ta começando com 1 mesmo declarando como 0

signal print : std.STANDARD.INTEGER := 0;
begin
    process(pixel)
    begin
        if(pixel /= "UUUUUUUU") then
            --vetor_nao_ordenado(contador) <= pixel;
            vetor_ordenado(contador) <= pixel;
            contador <= contador + 1;
            if(contador > 8) then
                contador <= 0;
            end if;
        end if;
    end process;

    process(calcular)
        begin
            --vetor_ordenado <= vetor_nao_ordenado;-- o vetor odenado NÃO está recebendo os valores
            
            
            --if(contador > 2) then -- precisa ter pelo menos dois itens no vetor, pra poder comparar
            
            if (calcular = '1') then
                pivo_aux <= std_logic_vector(to_unsigned(pivo+1, tamanho'length));--transforma o pivo em std_logic para poder comparar
                print <= 3;
                tam_aux <= conv_integer(tamanho);
            while tam_aux > pivo+1 loop -- não ta entrando no loop
                
                print <= 5;

                if(vetor_ordenado(pivo) > vetor_ordenado(pivo+1)) then
                    temporario <= vetor_ordenado(pivo);
                    --vetor_ordenado(pivo) <= vetor_ordenado(pivo+1);
                    --vetor_ordenado(pivo+1) <= temporario;
                    pivo <= 0;
                else 
                    pivo <= pivo + 1;
                end if;

            end loop;
            end if;

    end process;

    process(pivo)
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
	