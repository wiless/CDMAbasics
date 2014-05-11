% BASIC cdma test with my code

% clc
% close all
clear

SF=8;
profile=[0:-3:12].';
K=100; % No of symbols;
% X=hadamard(SF);
[Gigcode]=gigcode(SF,3);
[U D V]=svd(Gigcode);
X=V
CH_CODE1=2;
CH_CODE2=3;
code1=X(CH_CODE1,:)';code2=X(CH_CODE2,:)';
AWGN=1;
COUNT=1;
vSNR=0:5:30;
% vSNR=0;
TAPS=10;
profile=[0:-3:-3*(TAPS-1)].'; % Exponential decay
% profile=ones(TAPS,1);

PROFILE=10.^(profile/10); % Converted to LinearTAPS=5;
PROFILE=PROFILE/sqrt(sum(abs(PROFILE).^2));  % Normalizing the Profile

Eb=1/2;
Eu=1;
disp('start..');
for SNR=vSNR;
	snr=10^(SNR/10);			
	No=Eb*Eu/(snr);
	
	tempber=0;
	BLOCKS=1000;
% 	if(SNR>15) 
% 		BLOCKS=1000;
% 	end
	for blk=1:BLOCKS
		% Tx Model goes here
		txbits=randsrc(2*K,1,[0 1]);txsymbols=modulatebits(txbits);
		txchips=spread(code1,txsymbols);
		
        % Scrambling Generator
%         scrcode=randsrc(SF*K+2*SF,1,[1 -1]);
%         txchips=scrambler(scrcode,txchips);

        % USER-2 processing
% 		scrcode1=randsrc(SF*K+2*SF,1,[1 -1]);
% 		xbits=randsrc(2*K,1,[0 1]);
% 		txsymbols=modulatebits(xbits);
% 		xchips=spread(code2,txsymbols);
% 		txchips=txchips+scrambler(-scrcode,xchips,0);
% 		txchips=txchips*sqrt(Eu);


		% CHANNEL will GO here
		H=complex(randn(TAPS,1),randn(TAPS,1))*sqrt(0.5);
		channel_coef=H.*PROFILE;

		txchips=conv(channel_coef,txchips);
		if(AWGN==1)
			rxchips=txchips+sqrt(No)*complex(randn(length(txchips),1),randn(length(txchips),1))*sqrt(1/2);
		else
			rxchips=txchips;
		end

	 	% Receiver will go here
% 		rxsymbols=RAKEreceiver(code1,rxchips,channel_coef,scrcode,0);  % rxsymbols=txsymbols
				rxsymbols=RAKEreceiver(code1,rxchips,channel_coef);  % rxsymbols=txsymbols

		rxbits=demodulatebits(rxsymbols);
        rxbits=rxbits(1:2*K);
		% [txbits rxbits]
		tempber=tempber+nnz(txbits-rxbits)/(2*K);
	end
	ber(COUNT)=tempber/BLOCKS
	COUNT=COUNT+1;
end
% fname=sprintf('result_%dTaps_Fading_AWGN%d_CODE%d_%d.mat',TAPS,AWGN,CH_CODE1,CH_CODE2);
% disp('done ..');
% disp(['See filename : ' fname]);
% save(fname,vSNR,ber,TAPS,CH_CODE1);
%  openfig mmsefading;hold on;
semilogy(vSNR,ber,'r-X');
grid on;
%  legend 'MMSE' 'RAKE'

