library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity divider105 is
	port(
		clkin	: in std_logic;
		clkout	: out std_logic );
	end divider105;

architecture structure of divider105 is
	signal tmp1,tmp2,tmp3,tmp4 : std_logic;
	component divider10 is
    port(
		clkin	: in std_logic;
		clkout	: out std_logic );
	end component;
begin
	
	U0 : divider10  port map(clkin,tmp1);
	U1 : divider10  port map(tmp1,tmp2);
	U2 : divider10  port map(tmp2,tmp3);
	U3 : divider10  port map(tmp3,tmp4);
	U4 : divider10  port map(tmp4,clkout);

end structure;
	