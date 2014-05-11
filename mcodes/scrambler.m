function outputchips = scrambler(scramcode,inputchips,offset)
if nargin<3
    offset=0;
end
LEN=length(inputchips);
index=(1:LEN)+offset;
if(length(scramcode)<LEN+offset)
    disp('Scramble code length not enoough');
outputchips=-1;
else
outputchips=scramcode(index).*inputchips;
end

