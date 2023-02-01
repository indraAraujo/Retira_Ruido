library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--use std_logic_signed.all;

use ieee.numeric_std.all;
use ieee.NUMERIC_STD.unsigned;

use ieee.std_logic_arith.all;
use ieee.std_logic_arith.unsigned;



entity recebePixels is
	port(   
        pixel : in std_logic_vector(7 downto 0); 
        clock : in std_logic;
        pixelEnviado : in std_logic
		);
end entity;

architecture behavior of recebePixels is
    type vetor is array (0 to 8) of std_logic_vector(7 downto 0);
    signal vetor_ordenado : vetor;
    signal contador : std.STANDARD.INTEGER := 0;

begin
    process(clock)
    begin
        if rising_edge(clock) then
            if(pixelEnviado='1') then
                if(pixel /= "UUUUUUUU") then
                    vetor_ordenado(contador) <= pixel;
                    contador <= contador + 1;
                    if(contador > 8) then
                        contador <= 0;
                    end if;
                end if;
            end if;
    end if;
    end process;
end behavior;
	