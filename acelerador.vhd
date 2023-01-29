library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use ieee.std_logic_arith.all;
use ieee.std_logic_arith.UNSIGNED;

use ieee.numeric_std.all;
use ieee.NUMERIC_STD.UNSIGNED;

entity acelerador is
	port(
            tamanho       : in std_logic_vector(4 downto 0); 
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
signal pivo : std.STANDARD.INTEGER := 0;

signal terminado : std_logic := '0';
signal mediana_temporaria : std_logic_vector(7 downto 0) := "00000000"; 

signal contador : std.STANDARD.INTEGER := 0;
begin
    process(pixel)
    begin
        vetor_nao_ordenado(contador) <= pixel;
        contador <= contador + 1;
    end process;
    vetor_ordenado <= vetor_nao_ordenado;

    process(pivo)
        begin
            while pivo < tamanho loop
                if(vetor_ordenado(pivo) > vetor_ordenado(pivo+1)) then
                    temporario <= vetor_ordenado(pivo);
                    vetor_ordenado(pivo) <= vetor_ordenado(pivo+1);
                    vetor_ordenado(pivo+1) <= temporario;
                    pivo<=0;
                else 
                    pivo <= pivo+1;
                end if;
            end loop;
            if(pivo=tamanho) then
                mediana_temporaria <= vetor_ordenado(4);--(vetor((to_integer(tamanho) / 2))+vetor((to_integer(tamanho)/2)-1))/2;
                terminado<='1';
            end if;

    end process;
    
    
    process(calcular, terminado)
        begin
            if(calcular='1' AND terminado='1') then
                mediana <= mediana_temporaria;
            end if;
        end process;
end behavior;
	