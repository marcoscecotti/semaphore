--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:13:26 06/14/2018
-- Design Name:   
-- Module Name:   C:/Users/Milton/Desktop/VHDLs/TP2018/Semaforo/tb_clk_div_1hz.vhd
-- Project Name:  Semaforo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: clk_div_1hz
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

ENTITY tb_clk_div_1hz IS
END tb_clk_div_1hz;

ARCHITECTURE behavior OF tb_clk_div_1hz IS 
	COMPONENT clk_div_1hz
	PORT(
		clk_in : IN  std_logic;
		reset  : IN  std_logic;
		clk_out: OUT std_logic
	);
	END COMPONENT;

	-- Inputs
	signal clk_in  : std_logic := '0';
	signal reset   : std_logic := '0';
	-- Outputs
	signal clk_out : std_logic;
	constant clk_in_t : time := 10 ns; 
BEGIN 
	-- Instance of unit under test.
	uut: clk_div_1hz PORT MAP (
		clk_in  => clk_in,
		reset   => reset,
		clk_out => clk_out
	);

	-- Clock definition.
	entrada_process :process
		begin
		clk_in <= '0';
		wait for clk_in_t / 2;
		clk_in <= '1';
		wait for clk_in_t / 2;
	end process;

	-- Processing.
	stimuli: process
	begin
		reset <= '1'; -- Initial conditions.
		wait for 100 ns;
		reset <= '0'; -- Down to work!
        wait;
	end process;
END;