function [expo,mant] = ieee754(x)
%IEEE754 Decompose a double precision number.
% Input:
%   x     double precision number (scalar)
% Output:
%   e     exponent (as a string in base 2)
%   f     mantissa (as a string in base 2)

hex = num2hex(x);        % string of 16 hex digits for x
dec = hex2dec(hex');     % decimal for each digit (1 per row)
bin = dec2bin(dec,4);    % 4 binary digits per row
bitstr = reshape(bin',[1 64]);  % string of 64 bits in order
expo = bitstr(2:12);
mant = bitstr(13:64);

end