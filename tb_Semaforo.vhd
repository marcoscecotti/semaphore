--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:49:33 06/14/2018
-- Design Name:   
-- Module Name:   C:/Users/Milton/Desktop/Semaforo_con_divisor/tb_Semaforo.vhd
-- Project Name:  Semaforo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Semaforo
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_Semaforo IS
END tb_Semaforo;
 
ARCHITECTURE behavior OF tb_Semaforo IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Semaforo
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         Rojo1 : OUT  std_logic;
         Amarillo1 : OUT  std_logic;
         Verde1 : OUT  std_logic;
         Rojo2 : OUT  std_logic;
         Amarillo2 : OUT  std_logic;
         Verde2 : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal Rojo1 : std_logic;
   signal Amarillo1 : std_logic;
   signal Verde1 : std_logic;
   signal Rojo2 : std_logic;
   signal Amarillo2 : std_logic;
   signal Verde2 : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Semaforo PORT MAP (
          clk => clk,
          rst => rst,
          Rojo1 => Rojo1,
          Amarillo1 => Amarillo1,
          Verde1 => Verde1,
          Rojo2 => Rojo2,
          Amarillo2 => Amarillo2,
          Verde2 => Verde2
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
