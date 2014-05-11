function symbols=modulatebits(inputbits,constellation)
% modulatebits(inputbits,constellation)
% example to generate bits 
% bits=randsrc(Nbits,1,[0 1]);
%if(nargin==1)
	LEN=length(inputbits)/2;
	ind=[0:3].';
	constellation=exp(j*(ind*2*pi/4+pi/4));
	gray_code=[0 3 1 2]; %[00 01 11 10]
	constellation_gray=constellation(gray_code+1); % Reordering constellation

    %16qam
	%ind=bin2dec(reshape(num2str(inputbits)',4,length(inputbits)/4).')
    
    %qpsk
    ind=bin2dec(reshape(num2str(inputbits)',2,length(inputbits)/2).');
	symbols=constellation(ind(:)+1);
%end
end
