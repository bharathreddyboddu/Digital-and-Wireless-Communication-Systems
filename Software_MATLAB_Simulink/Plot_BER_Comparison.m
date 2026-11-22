% Load QPSK results
QPSK = load('QPSK_BER.mat');
% Load BPSK results
PSK = load('BPSK_BER.mat');

% Common plot
figure;
semilogy(QPSK.EbNo_values, QPSK.BER_QPSK, 'o-', 'LineWidth', 1.5);
hold on;
semilogy(PSK.EbNo_values, PSK.BER_BPSK, 's-', 'LineWidth', 1.5);
grid on;
xlabel('E_b/N_0 (dB)');
ylabel('BER');
title('QPSK and BPSK BER Performance over AWGN Channel');
legend('QPSK', 'BPSK', 'Location', 'southwest');
