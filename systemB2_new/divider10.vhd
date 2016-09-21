library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity divider10 is
	generic(LEN	:integer:=5);
	port(
		clkin	: in std_logic;
		clkout	: out std_logic );
	end divider10;
	architecture behav of divider10 is
	signal s_cnt : integer ;
	signal ss_cnt : std_logic_vector(2 downto 0);
begin
	process(clkin)
	variable cnt	: integer range 0 to LEN-1;
	variable clkt :std_logic;
	begin 
	if rising_edge(clkin) then
	  if cnt = LEN-1 then
	    if clkt = '1' then
	       clkt :='0';
	    else
		   clkt :='1';
		   end if;
		   cnt := 0 ;
	  else
			cnt := cnt+1;
	  end if;
	     s_cnt<=cnt;
	     ss_cnt<=conv_std_logic_vector(s_cnt,3);
	     clkout<=clkt and ss_cnt(2) and (ss_cnt(1) nor ss_cnt(0));
	  end if;
	 end process;
end behav;