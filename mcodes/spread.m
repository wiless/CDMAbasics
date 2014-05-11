% function chips=spread(spcode,inputsymbols)
% This will spread the data so that the output is unit energy ber bit.
function chips=spread(spcode,inputsymbols)
% This will spread the data so that the output is unit energy ber bit.
spcode=spcode/sqrt(sum(abs(spcode)));  % Normalizing the Code 
SF=length(spcode);
upsampled_sym=upsample(inputsymbols,SF);
chips=filter(spcode,1,upsampled_sym);
end