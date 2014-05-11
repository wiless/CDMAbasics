% function symbols=despread(rxchips,spcode)
function symbols=despread(rxchips,spcode)
LEN=length(rxchips);
SF=length(spcode);
sym=1;
for cnt=1:SF:LEN
	symbols(sym,1)=(spcode.')*rxchips(cnt:(cnt+SF-1));
	sym=sym+1;
end
end