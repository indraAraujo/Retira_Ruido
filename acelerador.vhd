library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity memory_fsm is
	port(
            tamanho       : in std_logic_vector(7 downto 0); 
            pixel         : in std_logic_vector(8 downto 0); 
            calcular      : in std_logic;
            mediana       : out std_logic_vector(8 downto 0); 
		);
end entity;

architecture behavior of memory_fsm is

type vetor is array (8 to 0) of std_logic_vector(9 downto 0);
signal vetor_nao_ordenado : vetor;
signal vetor_ordenado : vetor;

signal temporario : std_logic_vector(8 downto 0);
signal pivo : std_logic_vector(8 downto 0);

signal terminado : std_logic := '0';
signal mediana_temporaria : std_logic_vector(8 downto 0); 

signal contador : std_logic_vector(8 downto 0);
begin
    process(pixel)
    begin
        vetor_nao_ordenado(contador) <= pixel;
        contador <= contador +1;
    end process;
    vetor_ordenado <= vetor_nao_ordenado;
    
    while pivo < tamanho loop
        if(vetor_ordenado(pivo) > vetor_ordenado(pivo+1)) then
            temporario <= vetor_ordenado(pivo);
            vetor_ordenado(pivo) <= vetor_ordenado(pivo+1);
            vetor_ordenado(pivo+1) <= temporario;
            pivo<="000000000";
        else 
            pivo <= pivo+1;
        end if;
    end loop;
    mediana_temporaria <= (vetor((tamanho/2))+vetor((tamanho/2)-1))/2;
    terminado<='1';
    process(calcular, terminado)
        begin
            if(calcular=='1' AND terminado=='1') then
                mediana <= mediana_temporaria;
            end if;
        end process;
end behavior;
	