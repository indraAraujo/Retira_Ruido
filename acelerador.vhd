library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity memory_fsm is
	port(
            tamanho       : in std_logic_vector(3 downto 0); -- !TODO: QUAL O TAMANHO DESSE VETOR?
            pixel         : in std_logic_vector(1 downto 0); 
            calcular      : in std_logic_vector;
            mediana       : out std_logic_vector(3 downto 0); 
		);
end entity;

architecture behavior of memory_fsm is
    function bitonicMerge(
                vetor   : std_logic_vector(3 downto 0);
                menor   : std_logic;
                direcao : std_logic
            ) return std_logic_vector(3 downto 0) is
        variable k : integer;
        variable i : integer;
        variable temp : integer;
        variable maximo : integer;
        variable novo_vetor : std_logic_vector(3 downto 0);
    begin 
        if(tamanho>1) 
            begin
                k <= tamanho/2;
                maximo <= menor+k;
                for i in menor to maximo generate
                   if((vetor(i) > vetor(i+k) & direcao==1)|(vetor(i) < vetor(i+k) & direcao==0))
                    begin
                        temp <= vetor(i);
                        vetor(i) <= vetor(i+k);
                        vetor(i+k) <= temp;
                    end if;
                end generate;
                novo_vetor <= bitonicMerge(vetor, menor, k, direcao);
                novo_vetor <= bitonicMerge(novo_vetor, menor+k, k, direcao);
            end if;
        return novo_vetor;
    end function;

    function bitonicSort(
                            vetor   : std_logic_vector(3 downto 0);
                            menor   : std_logic;
                            direcao : std_logic
                        ) return std_logic_vector(3 downto 0) is
        variable k : integer;
        variable novo_vetor : std_logic_vector(3 downto 0);
    begin
        if(tamanho>1) 
            begin
                k <= tamanho/2;
                novo_vetor <= bitonicSort(vetor, menor, k, 1);
                novo_vetor <= bitonicSort(novo_vetor, menor+k, k, 0);
                novo_vetor <= bitonicMerge(novo_vetor, menor, direcao);
            end if;
        return novo_vetor;
    end function;

    function mediana(
                        vetor   : std_logic_vector(3 downto 0);
                    )return integer is
        variable mediana: integer;
    begin
        mediana <= (vetor((tamanho/2))+vetor((tamanho/2)-1))/2;
        return mediana;
    end function;

    function vetorFinal(
                          matriz : std_logic_vector(3 downto 0) --MUDAR PARA MATRIZ  
                        ) return std_logic_vector(tamanho-1 downto 0) is
        variable i : integer;
        variable vetor : std_logic_vector(3 downto 0);
        variable j : integer;
        variable index : integer;
    begin 
        for i in matriz'range(1) loop
            for j in matriz'range(2) loop
                vetor(index) <= matriz(i)(j);
                index <= index + 1;
            end loop;
        end loop;
    end function;
signal i : integer;
signal vetorFinal : std_logic_vector(tamanho downto 0);
begin
    process(calcular)
        begin
            if(calcular=='1')
                begin
                    for i in 0 to tamanho generate
                       bitonicSort(matriz(i), 0, tamanho, 1);
                    end generate;
                    vetorFienal <= vetorFinal(matriz);
                    mediana <= mediana(vetorFinal);
                end if;
        end process;
end behavior;
	