library ieee;
use work.all;
use ieee. std_logic_1164.all;

entity runsewe_16to9bitmar is
 port( 
	RST : in std_logic;
	CLK : in std_logic;
	EN : in std_logic;
	BUS_IN : in std_logic_vector(15 downto 0);
	MAR_OUT : out std_logic_vector(8 downto 0)
     );

end runsewe_16to9bitmar;

architecture mar16to9 of runsewe_16to9bitmar is 
   signal S_D : std_logic_vector(8 downto 0);
begin
   PETFF_CLK: process (CLK) 
      begin
	 if (CLK = '1' and CLK'event) then
		if (RST = '1') then
		  S_D <= (others => '0');
		elsif (EN = '1') then
		  S_D <= BUS_IN(8 downto 0);
		else
		  S_D <= (others => 'Z'); 
		end if;
         else
            S_D <= S_D;
 	end if;
end process PETFF_CLK;
 MAR_OUT <= S_D;
end mar16to9;
