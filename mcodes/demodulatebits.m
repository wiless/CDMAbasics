function bits=demodulatebits(symbols,constellation)
ind=0:3;

if(nargin==1)
	constellation=exp(j*(ind*2*pi/4+pi/4));
	gray_code=[0 3 1 2]; %[00 01 11 10]
	constellation_gray=constellation(gray_code+1); % Reordering constellation
	LEN=length(symbols);
	for cnt=1:LEN
		intsym(cnt)=ml(constellation,symbols(cnt));
	end

	binsym=dec2bin(intsym,2).';
	bits=str2num(binsym(:));
else
	
	LEN=length(symbols);
	for cnt=1:LEN
		intsym(cnt)=ml(constellation,symbols(cnt));
    end	
    %16QAM
	%binsym=dec2bin(intsym,4).';

    %QPSK
    binsym=dec2bin(intsym,2).';
	bits=str2num(binsym(:));
end

end


function indx=ml(constel,symbol)
dist=constel-symbol;
indx=find(dist==min(dist))-1;
end