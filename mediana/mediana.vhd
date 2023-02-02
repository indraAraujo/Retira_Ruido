library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use std_logic_signed.all;

use ieee.numeric_std.all;
use ieee.NUMERIC_STD.unsigned;

use ieee.std_logic_arith.all;
use ieee.std_logic_arith.unsigned;



entity mediana is
	port(   
        calcular : in std_logic;
        tamanho : in std_logic_vector(3 downto 0);
        clock : in std_logic
		);
end entity;

architecture behavior of mediana is
    type vetor is array (0 to 8) of std_logic_vector(7 downto 0);
    signal vetor_ordenado : vetor :=( "00001011","00001001","00001000", "00010000", "00100010", "00000100", "01000100", "10001000", "00000000");
    signal tam_aux  : std.STANDARD.INTEGER := 0;
    signal mediana : std_logic_vector(7 downto 0);

begin
  tam_aux <= ((conv_integer(tamanho)*conv_integer(tamanho))/2);
  process(clock)
  begin
    if(rising_edge(clock) and calcular='1') then
      mediana <= vetor_ordenado(tam_aux);
    end if;

  end process;

end behavior;
	