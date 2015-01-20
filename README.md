# Hamming Code 
Implements Hamming (7,4) code, aslo known as single error-correcting codes. 
Contains 4 data bits, 3 parity bits. Switch 0 toggles between encode, 
which computes the parity bits for the code, and decode, which 
computes the error syndrome for the bits. Outputs to 7-segment display.
While decoding, 7-segment display points to error bit or no error.