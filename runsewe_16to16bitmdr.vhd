library ieee;
use work.all;
use ieee. std_logic_1164.all;

entity runsewe_16to16bitmdr is
 port( 
	RST : in std_logic;
	CLK : in std_logic;
	EN : in std_logic;
	BUS_IN : in std_logic_vector(15 downto 0); --From Bus (Write)
	MEM_IN : in std_logic_vector(15 downto 0); --From Mem (Read)
	MDR_OUT : out std_logic_vector(15 downto 0) --TO Bus
     );

end runsewe_16to16bitmdr;

architecture mdr16to16 of runsewe_16to16bitmdr is 
   signal S_D : std_logic_vector(15 downto 0);
begin
   PETFF_CLK: process (CLK) 
      begin
	 if (CLK = '1' and CLK'event) then
		if (RST = '1') then
		  S_D <= (others => '0');
		elsif (EN = '1') then
		  S_D <= BUS_IN;
		else
		  S_D <= MEM_IN; 
		end if;
         else
            S_D <= S_D;
 	end if;
end process PETFF_CLK;
 MDR_OUT <= S_D;
end mdr16to16;
