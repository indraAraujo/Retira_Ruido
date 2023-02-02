library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

-- DÚVIDAS PRINCIPAIS:
-- 1. COMO TRANSFORMAR INTEGER EM BINÁRIO PARA QUE O FPGA CONSIGA SINTETIZAR?
-- 2. CONSIGO COLOCAR UM SIGNAL ANTES DE UMA FUNÇÃO? -> necessário para conseguir declarar 
-- um tipo e fazer vetores 
-- 3. OS MEUS IFs ESTÃO CORRETOS?
-- 4. AS MINHAS CHAMADAS DE FUNÇÃO ESTÃO CORRETAS?


entity memory_fsm is
	port(
            tamanho       : in std_logic_vector(3 downto 0); -- !TODO: QUAL O TAMANHO DESSE VETOR?
            pixel         : in std_logic_vector(1 downto 0); 
            calcular      : in std_logic_vector;
            mediana       : out std_logic_vector(3 downto 0); 
		);
end entity;

architecture behavior of memory_fsm is
    -- FAZER O ORDENAMENTO
    function ordenamento(
                vetor   : std_logic_vector(3 downto 0); -- COMO PASSAR UM VETOR DE INTEIROS COMO PARAMETRO
                direita   : std_logic;
                esquerda : std_logic
            ) return std_logic_vector(3 downto 0) is -- COMO RETORNAR UM VETOR
        variable pivo1 : integer; 
        variable pivo2 : integer;
        variable minimo : integer;
        variable maximo : integer;
        variable k      : integer;
        variable temp   : integer;
        variable novo_vetor : std_logic_vector(3 downto 0);
    begin 
        if(esquerda < direita) 
            begin
                pivo1 <= vetor(esquerda);
                pivo2 <= vetor(direita);
                minimo <= esquerda +1;
                maximo <= direita-1;
                novo_vetor <= vetor;
                for k in minimo to maximo generate
                   if(vetor(k)<pivo1)
                   begin
                        novo_vetor(k) <= vetor(minimo);
                        novo_vetor(minimo) <= vetor(k);
                        minimo <= minimo+1;
                    elsif(vetor(k) >= pivo2)
                        while (k<maximo AND vetor(maximo)>pivo2)
                            maximo <= maximo -1;
                        end loop;
                        novo_vetor(k) <= vetor(maximo);
                        novo_vetor(maximo) <= vetor(k);
                        maximo <= maximo-1;
                        if(vetor(k) <pivo1)
                        begin
                            temp <= novo_vetor(k);
                            novo_vetor(k) <= novo_vetor(minimo);
                            novo_vetor(minimo) <= temp;
                            minimo <= minimo +1;
                        end if;
                    end if;
                end generate;
                temp <= novo_vetor(esquerda);
                novo_vetor(esquerda) <= novo_vetor(minimo-1);
                novo_vetor(minimo-1) <= temp;

               novo_vetor <= ordenamento(novo_vetor, esquerda, minimo-2);
               novo_vetor <= ordenamento(novo_vetor, maximo +2, direita);

               if(minimo < maximo)
               begin
                    novo_vetor <= ordenamento(novo_vetor, minimo, maximo);
                end if;
            end if;
        return novo_vetor;
    end function;

    -- CONSEGUIR A MEDIANA
    function mediana(
                        vetor   : std_logic_vector(3 downto 0);
                    )return integer is
        variable mediana: integer;
    begin
        mediana <= (vetor((tamanho/2))+vetor((tamanho/2)-1))/2;
        return mediana;
    end function;
    -- TRANSFORMAR A MATRIZ EM UM VETOR 1D
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
signal tamanhoVetor : integer := tamanho*tamanho;
begin
    process(calcular)
        begin
            if(calcular=='1')
                begin
                    for i in 0 to tamanho generate
                       ordenamento(matriz(i), 0, tamanho-1,);
                    end generate;
                    vetorFinal <= vetorFinal(matriz);
                    vetorFinal <= ordenamento(vetorFinal, 0, tamanhoVetor);
                    mediana <= mediana(vetorFinal);
                end if;
        end process;
end behavior;
	