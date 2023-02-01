library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

use ieee.std_logic_arith.all;
use ieee.std_logic_arith.UNSIGNED;

use ieee.numeric_std.all;
use ieee.NUMERIC_STD.UNSIGNED;

entity testbenchOV is
end entity;

architecture behavior of testbenchOV is

    component ordenarVetor is port (
        tamanho       : in std_logic_vector(3 downto 0); 
        calcular      : in std_logic;
        clock : in std_logic
    );
    end component;

    signal tmnh         : std_logic_vector(3 downto 0);
    signal px           : std_logic_vector(7 downto 0); 
    signal calc         : std_logic := '0';
    signal med          : std_logic_vector(7 downto 0);
    signal clk          : std_logic:='0';
begin
    acel: ordenarVetor port map(
		tamanho     => tmnh,
            clock           => clk,
            calcular    => calc);

 
            clk <= not clk after 15 ns;

    process
        begin
            calc <= '0';
            wait for 6 ns;
            tmnh <= "1001"; -- 9
            calc <= '1';
            wait for 2000 ns;
               
                 
        end process;
end behavior;