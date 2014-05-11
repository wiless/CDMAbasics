% function RAKEreceiver(spcode,rxchips,channel,scramblecode,offset)
% 3rd Aug 
%
function rakeoutput=RAKEreceiver(spcode,rxchips,channel,scramblecode,offset)
spcode=spcode/sqrt(sum(abs(spcode)));  % Normalizing the Code 
rlen=length(rxchips);
SF=length(spcode);
TAPS=length(channel);
LEN=floor(rlen/SF);
rakeoutput=zeros(LEN,1);

if nargin<5
	offset=0;
end
		
if nargin<4
    SCRAMBLE=0;
	offset=0;
%     disp('Scrambling Passed');
else    
    SCRAMBLE=1;
end

descr_chips=0;
rxchips(SF*LEN+TAPS-1)=0;

for finger=1:TAPS
	indx=1:(SF*LEN);
	indx=indx+finger-1;	
    
   
	if SCRAMBLE==1
    descr_chips=scrambler(conj(scramblecode),rxchips(indx),offset);
    else
    descr_chips=rxchips(indx);
    end
        
	rakeoutput=rakeoutput+conj(channel(finger))*despread(descr_chips,spcode);		    
end
end

function symbols=despread(rxchips,spcode)
LEN=length(rxchips);
SF=length(spcode);
sym=1;
for cnt=1:SF:LEN
	symbols(sym,1)=(spcode.')*rxchips(cnt:(cnt+SF-1));
	sym=sym+1;
end
end