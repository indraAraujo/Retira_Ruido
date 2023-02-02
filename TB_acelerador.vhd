library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use ieee.std_logic_arith.all;
use ieee.std_logic_arith.UNSIGNED;

use ieee.numeric_std.all;
use ieee.NUMERIC_STD.UNSIGNED;

entity TB_acelerador is
end entity;

architecture behavior of TB_acelerador is

    component acelerador is port (
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
    end component;

    signal tmnh         : std_logic_vector(1 downto 0):="00";
    signal clk          : std_logic:='0';
    signal ack          : std_logic:='0';
    signal px           : std_logic_vector(7 downto 0); 
    signal calc         : std_logic:='0';
    signal med          : std_logic_vector(7 downto 0);
    signal prt          : std_logic;
    signal i : std.STANDARD.INTEGER := 1;

begin
    acel: acelerador port map(
		enable_tamanho      => tmnh,
        clock               => clk,
        ack_pixelEnviado    => ack,
        pixel       => px,
        calcular    => calc,
        mediana     => med,
        pronto      => prt);

    clk <= not clk after 1 ns;

--process(prt)
----begin
------tmnh <= tmnh + "01"; -- Informa o tamanho do quadro = 3x3
----end process;

--process
----begin
------wait for 10 ns;
------
------while i <= 9 loop
--------px <= std_logic_vector(to_unsigned(9-i, px'length));
--------ack <= '1';
----------wait for 1 ns;
--------ack <= '0';
--------i <= i + 1;
----------wait for 2 ns;
------end loop;
--------calc <= '1';---- Informa que todos os pixels foram enviados
 
----end process;
    
process
begin
 --Testando para 3x3:
wait for 10 ns;
tmnh <= "00";  --Informa o tamanho do quadro = 3x3

wait for 2 ns;
px <= "10000000"; --1° pixel   --1° pixel
ack <= '1';
wait for 1 ns;
ack <= '0';
wait for 2 ns;
px <= "01100000"; --2° pixel
ack <= '1';
wait for 1 ns;
ack <= '0';
wait for 2 ns;
px <= "01110000"; --3° pixel
ack <= '1';
wait for 1 ns;
ack <= '0';   
wait for 2 ns;
px <= "01111000"; --4° pixel   
ack <= '1';
wait for 1 ns;
ack <= '0';
wait for 2 ns;
px <= "01111100"; --5° pixel   
ack <= '1';
wait for 1 ns;
ack <= '0';
wait for 2 ns;
px <= "01111110"; --6° pixel   
ack <= '1';
wait for 1 ns;
ack <= '0';   
wait for 2 ns;
px <= "01111111"; --7° pixel   
ack <= '1';
wait for 1 ns;
ack <= '0';   
wait for 2 ns;
px <= "00111111"; --8° pixel   
ack <= '1';
wait for 1 ns;
ack <= '0';
wait for 2 ns;
px <= "00011111"; --9° pixel   
ack <= '1';
wait for 1 ns;
ack <= '0';
wait for 5 ns;
calc <= '1'; --Informa que todos os pixels foram enviados
wait for 10000 ns;
end process;
end behavior;