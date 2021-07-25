----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:19:04 06/14/2018 
-- Design Name: 
-- Module Name:    semaforo_simple - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

entity semaforo_simple is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Rojo1 : out  STD_LOGIC;
           Amarillo1 : out  STD_LOGIC;
           Verde1 : out  STD_LOGIC;
           Rojo2 : out  STD_LOGIC;
           Amarillo2 : out  STD_LOGIC;
           Verde2 : out  STD_LOGIC);
end semaforo_simple;

architecture Behavioral of semaforo_simple is

COMPONENT clk_div_1hz
	PORT(
		clk_in : IN std_logic;
		reset : IN std_logic;          
		clk_out : OUT std_logic
		);
	END COMPONENT;


type state_type is (zero,one,two,three); 
signal EstadoActual, EstadoSiguiente : state_type; 

signal Reloj:STD_LOGIC;
signal Cuenta2:STD_LOGIC_VECTOR(5 DOWNTO 0):="000000";

begin

--Inicializador de estados
   SYNC_PROC: process (clk,rst)
   begin
	if (rst = '1') then
		EstadoActual <= zero;
      else if (clk'event and clk = '1') then
					EstadoActual <= EstadoSiguiente;
				end if;
				end if;
   end process;
 
--Transformar la frecuencia brindada por la FPGA, a 1 ciclo por segundo
	Inst_clk_div_1hz: clk_div_1hz PORT MAP(
		clk_in => clk,
		reset => rst,
		clk_out => Reloj
	);

 
--Cuenta desde 0 hasta 40
Temporizador: process(Reloj,rst)
begin
	if (rst='1') then
	Cuenta2<= (others => '0');
	elsif rising_edge(Reloj) then
		Cuenta2<=Cuenta2+1;
		if Cuenta2="100111" then
			Cuenta2<="000000";
		end if;
	end if;
end process;


--Definicion salida maquina de estados
   OUTPUT_DECODE: process (EstadoActual)
   begin
      if EstadoActual=zero then
						  Rojo1<='1';
						  Amarillo1<='0';
						  Verde1<='0';
					     Rojo2<='0';
					     Amarillo2<='0';
					     Verde2<='1';
      else if EstadoActual=one then
						  Rojo1<='1';
						  Amarillo1<='0';
						  Verde1<='0';
					     Rojo2<='0';
					     Amarillo2<='1';
					     Verde2<='0';
		else if EstadoActual=two then
					     Rojo1<='0';
						  Amarillo1<='0';
						  Verde1<='1';
					     Rojo2<='1';
					     Amarillo2<='0';
					     Verde2<='0';
		else if EstadoActual=three then
						  Rojo1<='0';
						  Amarillo1<='1';
						  Verde1<='0';
					     Rojo2<='1';
					     Amarillo2<='0';
					     Verde2<='0';
		else  
						  Rojo1<='0';
						  Amarillo1<='1';
						  Verde1<='0';
					     Rojo2<='0';
					     Amarillo2<='1';
					     Verde2<='0';
         
      end if;
		end if;
		end if;
		end if;
   end process;
 
 
 
 --Definicion estado siguiente maquina de estado
   NEXT_STATE_DECODE: process (EstadoActual, Cuenta2)
   begin
      EstadoSiguiente <= EstadoActual;
      case EstadoActual is
					when zero=>
					 if Cuenta2="10000" then
						EstadoSiguiente<=one;
					 else
						EstadoSiguiente<=zero;
					 end if;
					when one=>
					 if Cuenta2="10100" then
						EstadoSiguiente<=two;
					 else
						EstadoSiguiente<=one;
					 end if;
					when two=>
					 if Cuenta2="100100" then
						EstadoSiguiente<=three;
					 else
						EstadoSiguiente<=two;
					 end if;
					when three=>
					 if Cuenta2="000000" then
						EstadoSiguiente<=zero;
					 else
						EstadoSiguiente<=three;
					 end if;
			end case;      
   end process;


end Behavioral;