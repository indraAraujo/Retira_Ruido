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

    component recebePixels is port (
        pixel   : in std_logic_vector(7 downto 0); 
        clock   : in std_logic;
        pixelEnviado : in std_logic
    );
    end component;

    signal tmnh         : std_logic_vector(3 downto 0);
    signal px           : std_logic_vector(7 downto 0); 
    signal calc         : std_logic;
    signal med          : std_logic_vector(7 downto 0);
    signal clk          : std_logic:='0';
    signal pixEnv       : std_logic:='0';

begin
    acel: recebePixels port map(
            pixel           => px,
            clock           => clk,
            pixelEnviado    => pixEnv
        );

 
    clk <= not clk after 15 ns;
    process
        begin
            
            px <= "00000000";    
            pixEnv <= '0';   
            
            wait for 6 ns;
                px <= "00000010";
                pixEnv <= '1';
            wait for 6 ns;
                pixEnv <= '0';   
                px <= "00000100";
               pixEnv <= '1';
            wait for 6 ns;
                pixEnv <= '0';   
                px <= "00001000";
                pixEnv <= '1';
            wait for 6 ns;
                pixEnv <= '0';   
                px <= "00010000";
                pixEnv <= '1';
            wait for 6 ns;
                pixEnv <= '0';   
                px <= "00100010";
               pixEnv <= '1';
            wait for 6 ns;
                pixEnv <= '0';   
                px <= "01000100";
               pixEnv <= '1';
            wait for 6 ns;
                pixEnv <= '0';   
                px <= "10001000";
                pixEnv <= '1';
            wait for 6 ns;
                pixEnv <= '0';   
                px <= "10001001";
                pixEnv <= '1';
            wait for 60 ns;   
        end process;
end behavior;