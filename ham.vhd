----------------------------------------------------------------------------------
-- Engineer: Josue Casco 
-- Course ECE351
--
-- Project Name: HW1-2
--
-- Description: Implements Hamming (7,4) code. Switch 0 toggles between encode 
--              which computes the parity bits for the code and decode which 
--              computes the error syndrome for the bits. While decoding, 
--              7-segment display points to error bit or no error.
--

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ham is
    Port ( dat7, dat6, dat5, dat3 : in  STD_LOGIC; --input data bits         
           parIn4, parIn2, parIn1 : in  STD_LOGIC; --input parity bits
           enc : in  STD_LOGIC;
           parOut4, parOut2, parOut1 : out  STD_LOGIC; --parity output
           an0, an1, an2, an3, aBar, bBar,             --7-seg display
			  cBar, dBar, eBar, fBar, gBar : out  STD_LOGIC); 
end ham;

architecture Behavioral of ham is

SIGNAL parBit1, parBit2, parBit4: std_logic:='0';

begin
	PROCESS(enc)
	begin
		IF enc = '1' THEN --encoding, parity bits is computed and stored in signal
			parBit1 <= dat3 XOR dat5 XOR dat7;
			parBit2 <= dat3 XOR dat6 XOR dat7;
			parBit4 <= dat5 XOR dat6 XOR dat7;
		ELSIF enc = '0' THEN--decoding, error syndrome is computed and stored in signal
			parBit1 <= parIn1 XOR dat3 XOR dat5 XOR dat7;
			parBit2 <= parIn2 XOR dat3 XOR dat6 XOR dat7;
			parBit4 <= parIn4 XOR dat5 XOR dat6 XOR dat7;
		End IF;
	END PROCESS;
	
	parOut1 <= parBit1; --parity signal passed to output led
	parOut2 <= parBit2;
	parOut4 <= parBit4;
	
	PROCESS (enc, parBit1, parBit2, parBit4) --monitoring for 7-seg display
	begin
		IF enc = '1' THEN --while encoding, display is "E"			
			aBar <= '0';
			fBar <= '0';
			gBar <= '0';
			eBar <= '0';
			dBar <= '0';
			bBar <= '1';
			cBar <= '1';
			an0 <= '0';
			an1 <= '1';
			an2 <= '1';
			an3 <= '1';
		ElSIF (enc = '0') THEN -- while decoding, displays error bit
			IF(parBit1 = '1' AND parBit2 = '0' AND parBit4 = '0') THEN
				aBar <= '1';
				bBar <= '0';
				cBar <= '0';
				dBar <= '1';
				eBar <= '1';
				fBar <= '1';
				gBar <= '1';
				an0 <= '0';
				an1 <= '1';
				an2 <= '1';
				an3 <= '1';
			ELSIF(parBit1 = '0' AND parBit2 = '1' AND parBit4 = '0') THEN
				aBar <= '0';
				bBar <= '0';
				cBar <= '1';
				dBar <= '0';
				eBar <= '0';
				fBar <= '1';
				gBar <= '0';
				an0 <= '0';
				an1 <= '1';
				an2 <= '1';
				an3 <= '1';
			ELSIF(parBit1 = '1' AND parBit2 = '1' AND parBit4 = '0') THEN
				aBar <= '0';
				bBar <= '0';
				cBar <= '0';
				dBar <= '0';
				eBar <= '1';
				fBar <= '1';
				gBar <= '0';
				an0 <= '0';
				an1 <= '1';
				an2 <= '1';
				an3 <= '1';
			ELSIF(parBit1 = '0' AND parBit2 = '0' AND parBit4 = '1') THEN
				aBar <= '1';
				bBar <= '0';
				cBar <= '0';
				dBar <= '1';
				eBar <= '1';
				fBar <= '0';
				gBar <= '0';
				an0 <= '0';
				an1 <= '1';
				an2 <= '1';
				an3 <= '1';
			ELSIF(parBit1 = '1' AND parBit2 = '0' AND parBit4 = '1') THEN
				aBar <= '0';
				bBar <= '1';
				cBar <= '0';
				dBar <= '0';
				eBar <= '1';
				fBar <= '0';
				gBar <= '0';
				an0 <= '0';
				an1 <= '1';
				an2 <= '1';
				an3 <= '1';
			ELSIF(parBit1 = '0' AND parBit2 = '1' AND parBit4 = '1') THEN
				aBar <= '0';
				bBar <= '1';
				cBar <= '0';
				dBar <= '0';
				eBar <= '0';
				fBar <= '0';
				gBar <= '0';
				an0 <= '0';
				an1 <= '1';
				an2 <= '1';
				an3 <= '1';
			ELSIF(parBit1 = '1' AND parBit2 = '1' AND parBit4 = '1') THEN
				aBar <= '0';
				bBar <= '0';
				cBar <= '0';
				dBar <= '1';
				eBar <= '1';
				fBar <= '1';
				gBar <= '1';
				an0 <= '0';
				an1 <= '1';
				an2 <= '1';
				an3 <= '1';
			ELSE --no error
				aBar <= '0';
				bBar <= '0';
				cBar <= '0';
				dBar <= '0';
				eBar <= '0';
				fBar <= '0';
				gBar <= '1';
				an0 <= '0';
				an1 <= '1';
				an2 <= '1';
				an3 <= '1';
			END IF;
		END IF;
	END PROCESS;
	


end Behavioral;

