-- Copyright 2018 by Howard University All rights reserved.
--
-- Manual Testbench for: 
-- Name:   Ore Runsewe 
--	
-- Date:   10/23/2018
--
-- For Homework #5
-- Adv. Digital Design 
--------------------------------------------------------------


LIBRARY IEEE;
USE work.CLOCKS.all;   -- Entity that uses CLOCKS
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_textio.all;
USE std.textio.all;
USE work.txt_util.all;

ENTITY runsewe_tb_16to9bitmar IS
END;

ARCHITECTURE TESTBENCH OF runsewe_tb_16to9bitmar IS

---------------------------------------------------------------
-- COMPONENTS
---------------------------------------------------------------

COMPONENT runsewe_16to9bitmar 		-- In/out Ports
	PORT(	
	RST : in std_logic;
	CLK : in std_logic;
	en : in std_logic;
	BUS_IN : in std_logic_vector(15 downto 0);
	MAR_OUT : out std_logic_vector(8 downto 0)
);
END COMPONENT;

COMPONENT CLOCK
	port(CLK: out std_logic);
END COMPONENT;

---------------------------------------------------------------
-- Read/Write FILES
---------------------------------------------------------------


FILE in_file : TEXT open read_mode is 	"runsewe_16to9bitmarin.txt";   -- Inputs, RST, enr,enl
FILE exo_file : TEXT open read_mode is 	"runsewe_16to9bitmarout.txt";   -- Expected output (binary)
FILE out_file : TEXT open  write_mode is  "AMOO_EVENPD_Book_dataout_dacus.txt";
FILE xout_file : TEXT open  write_mode is "AMOO_EVENPD_Book_TestOut_dacus.txt";
FILE hex_out_file : TEXT open  write_mode is "AMOO_EVENPD_Book_hex_out_dacus.txt";

---------------------------------------------------------------
-- SIGNALS 
---------------------------------------------------------------
  SIGNAL RST: STD_LOGIC;
  SIGNAL BUS_IN: STD_LOGIC_VECTOR(15 DOWNTO 0);
  SIGNAL EN: STD_LOGIC;
  SIGNAL CLK: STD_LOGIC;
  SIGNAL MAR_OUT: STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL Exp_MAR_OUT : STD_LOGIC_VECTOR(8 DOWNTO 0);
  SIGNAL TEST_OUT_MAR : STD_LOGIC:= 'X';
  SIGNAL LineNumber: integer:=0;

---------------------------------------------------------------
-- BEGIN 
---------------------------------------------------------------

BEGIN

---------------------------------------------------------------
-- Instantiate Components 
---------------------------------------------------------------


U0: CLOCK port map (CLK );
Instrunsewe_16to9bitmar : runsewe_16to9bitmar  port map (RST, CLK, EN, BUS_IN, MAR_OUT);

---------------------------------------------------------------
-- PROCESS 
---------------------------------------------------------------
PROCESS

variable in_line, exo_line, out_line, xout_line : LINE;
variable comment, xcomment : string(1 to 128);
variable i : integer range 1 to 128;
variable simcomplete : boolean;
variable vBUS_IN   : std_logic_vector(15 downto 0):= (OTHERS => 'X');
variable vRST   : std_logic := '0';
variable vEN : std_logic := '0';
variable vMAR_OUT : std_logic_vector(8 downto 0):= (OTHERS => 'X');
variable vExp_MAR_OUT : std_logic_vector(8 downto 0):= (OTHERS => 'X');
variable vTEST_OUT_MAR : std_logic := '0';
variable vlinenumber: integer;

BEGIN

simcomplete := false;

while (not simcomplete) LOOP
  
	if (not endfile(in_file) ) then
		readline(in_file, in_line);
	else
		simcomplete := true;
	end if;

	if (not endfile(exo_file) ) then
		readline(exo_file, exo_line);
	else
		simcomplete := true;
	end if;
	
	if (in_line(1) = '-') then  --Skip comments
		next;
	elsif (in_line(1) = '.')  then  --exit Loop
	  TEST_OUT_MAR <= 'Z';
		simcomplete := true;
	elsif (in_line(1) = '#') then        --Echo comments to out.txt
	  i := 1;
	  while in_line(i) /= '.' LOOP
		comment(i) := in_line(i);
		i := i + 1;
	  end LOOP;

	elsif (exo_line(1) = '-') then  --Skip comments
		next;
	elsif (exo_line(1) = '.')  then  --exit Loop
	  	  TEST_OUT_MAR  <= 'Z';
		   simcomplete := true;
	elsif (exo_line(1) = '#') then        --Echo comments to out.txt
	     i := 1;
	   while exo_line(i) /= '.' LOOP
		 xcomment(i) := exo_line(i);
		 i := i + 1;
	   end LOOP;

	
	  write(out_line, comment);
	  writeline(out_file, out_line);
	  
	  write(xout_line, xcomment);
	  writeline(xout_file, xout_line);

	  
	ELSE      --Begin processing


		--  read(in_line, vBUS_IN );
		--  BUS_IN  <= vBUS_IN;

		--  read(exo_line, vexp_MAR_OUT );
	          --read(exo_line, vTEST_OUT_MAR );


		  read(in_line, vRST );
		  RST <= vRST;

		  read(in_line, vEN );
		  EN <= vEN;
 		  read(in_line, vBUS_IN );
		  BUS_IN <= vBUS_IN;

		  read(exo_line, vExp_MAR_OUT );
	          read(exo_line, vTEST_OUT_MAR );
		
		
    vlinenumber :=LineNumber;
    
    write(out_line, vlinenumber);
    write(out_line, STRING'("."));
    write(out_line, STRING'("    "));

	

   CYCLE(1,CLK);
    
    Exp_MAR_OUT     <= vExp_MAR_OUT;
    
      
    if (Exp_MAR_OUT = MAR_OUT) then
      TEST_OUT_MAR <= '0';
    else
      TEST_OUT_MAR <= 'X';
    end if;

		vMAR_OUT 	:= MAR_OUT;
		vTEST_OUT_MAR:= TEST_OUT_MAR;
          		
		write(out_line, vMAR_OUT, left, 32);
		write(out_line, STRING'("       "));                           --ht is ascii for horizontal tab
		write(out_line,vTEST_OUT_MAR, left, 5);                           --ht is ascii for horizontal tab
		write(out_line, STRING'("       "));                           --ht is ascii for horizontal tab
		write(out_line, vExp_MAR_OUT, left, 32);
		write(out_line, STRING'("       "));                           --ht is ascii for horizontal tab
		writeline(out_file, out_line);
		print(xout_file,    str(LineNumber)& "." & "    " &    str(MAR_OUT) & "          " &   str(Exp_MAR_OUT)  & "          " & str(TEST_OUT_MAR) );
	
	END IF;
	LineNumber<= LineNumber+1;

	END LOOP;
	WAIT;
	
	END PROCESS;

END TESTBENCH;


CONFIGURATION cfg_runsewe_tb_16to9bitmar OF runsewe_tb_16to9bitmar IS
	FOR TESTBENCH
		FOR Instrunsewe_16to9bitmar : runsewe_16to9bitmar 
		END FOR;
	END FOR;
END;
