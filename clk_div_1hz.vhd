library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_div_1hz is
    Port ( clk_in : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
           clk_out : out  STD_LOGIC);
end clk_div_1hz;

architecture Behavioral of clk_div_1hz is
    signal temporal: STD_LOGIC := '0';
    signal counter : integer range 0 to 24999999:= 0;
begin
    frequency_divider: process (reset, clk_in) begin
		   if (reset = '1') then
            temporal <= '0';
            counter <= 0;
		  elsif rising_edge(clk_in) then
            if (counter = 24999999) then
                temporal <= NOT(temporal);
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    clk_out <= temporal;
end Behavioral;