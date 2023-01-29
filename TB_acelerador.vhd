library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity TB_acelerador is
end entity;

architecture behavior of TB_acelerador is

    component acelerador is port (
        tamanho       : in std_logic_vector(3 downto 0); 
        pixel         : in std_logic_vector(7 downto 0); 
        calcular      : in std_logic;
        mediana       : out std_logic_vector(7 downto 0));
    end component;

    signal tmnh         : std_logic_vector(3 downto 0);
    signal px           : std_logic_vector(7 downto 0); 
    signal calc         : std_logic;
    signal med          : std_logic_vector(7 downto 0);

begin
    acel: acelerador port map(
		tamanho     => tmnh,
        pixel       => px,
        calcular    => calc,
        mediana     => med);

 

    process
        begin
            
            
            px <= "00000000";                
            tmnh <= "1001"; -- 9
            calc <= '0';
            
            wait for 10 ns;
                --tmnh <= "0010"; -- 2
                px <= "00000010";
               
            wait for 10 ns;
                --tmnh <= "0011"; -- 3
                px <= "00000100";
               
            wait for 10 ns;
                --tmnh <= "0100"; -- 
                px <= "00001000";
            
            wait for 10 ns;
                --tmnh <= "0101"; -- 
                px <= "00010000";
           
            wait for 10 ns;
                --tmnh <= "0110"; -- 
                px <= "00100010";
               
            wait for 10 ns;
                --tmnh <= "0111"; -- 
                px <= "01000100";
               
            wait for 10 ns;
                --tmnh <= "1000"; -- 8
                px <= "10001000";

            wait for 10 ns;
                --tmnh <= "1001"; -- 9
                px <= "10001001";
                
            wait for 5 ns;
                calc <= '1';
            wait for 50 ns;   
        end process;
end behavior;