library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use std_logic_signed.all;

use ieee.numeric_std.all;
use ieee.NUMERIC_STD.unsigned;

use ieee.std_logic_arith.all;
use ieee.std_logic_arith.unsigned;



entity ordenarVetor is
	port(   
        calcular : in std_logic;
        tamanho : in std_logic_vector(3 downto 0);
        clock : in std_logic
		);
end entity;

architecture behavior of ordenarVetor is
    type vetor is array (0 to 8) of std_logic_vector(7 downto 0);
    signal vetor_ordenado : vetor :=( "10001001","10001001","00001000", "00010000", "00100010", "00000100", "01000100", "10001000", "00000000");
    signal tam_aux  : std.STANDARD.INTEGER := 0;
    signal pivo : std.STANDARD.INTEGER := 1;
    signal temporario : std_logic_vector(7 downto 0);
--signal print : std.STANDARD.INTEGER := 0;
signal i, j : integer range 0 to 8-1;
  signal swapped : boolean;
signal fim : std_logic := '0';
begin
  process(clock)
  begin
    if(rising_edge(clock) and calcular='1') then
        if i < 8 then
            if j < 8-i then
              if vetor_ordenado(j) > vetor_ordenado(j+1) then
                temporario <= vetor_ordenado(j);
                vetor_ordenado(j) <= vetor_ordenado(j+1);
                vetor_ordenado(j+1) <= vetor_ordenado(j);
                swapped <= true;
              end if;
              j <= j + 1;
            else
              j <= 0;
              i <= i + 1;
            end if;
          elsif swapped = false then
            fim <= '1';
          end if;
    end if;

  end process;
end behavior;
	