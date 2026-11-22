model = 'BPSK_System_Over_AWGN_Channel';
% Eb/N0 values to test
EbNo_values = 0:1:9;
% Storage for simulated BER
BER_BPSK = zeros(size(EbNo_values));
% Run simulation for every Eb/N0 value
for k = 1:length(EbNo_values)
    % Set AWGN Eb/N0
    EbNo_dB = EbNo_values(k);
    % Run Simulink model
    out = sim(model);
    % Get final BER
    BER_BPSK(k) = out.BER_PSK.Data(end,1);
    fprintf('Eb/N0 = %2d dB    BER = %.6g\n', ...
        EbNo_dB, BER_BPSK(k));
end
% Display results
Results = table(EbNo_values', BER_BPSK', ...
    'VariableNames', {'EbNo_dB','BER'});
disp(Results);
% Calculate theoretical BER
EbN0 = 10.^(EbNo_values/10);
BER_theoretical = 0.5 * erfc(sqrt(EbN0));
% Plot simulated and theoretical BER together
figure;

semilogy(EbNo_values, BER_BPSK, 'ro-', ...
    'LineWidth', 1.8, 'MarkerSize', 7);

hold on;

semilogy(EbNo_values, BER_theoretical, 'b*-','LineWidth', 2, 'MarkerSize', 8);

grid on;
xlabel('E_b/N_0 (dB)');
ylabel('Bit Error Rate (BER)');

title('BPSK BER Performance over AWGN Channel');

legend('Simulated BPSK', 'Theoretical BPSK', ...
    'Location', 'southwest');

xticks(0:1:9);
xlim([0 9]);
ylim([1e-5 1]);

hold off;

% Save results
save('BPSK_BER.mat', 'EbNo_values','BER_BPSK', 'BER_theoretical');
