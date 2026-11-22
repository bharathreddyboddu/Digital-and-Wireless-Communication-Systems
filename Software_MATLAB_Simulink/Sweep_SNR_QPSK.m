

model = 'QPSK_System_Over_AWGN_Channel';

% Eb/N0 values to test
EbNo_values = 0:1:9;

% Storage for simulated BER
BER_QPSK = zeros(size(EbNo_values));

% Run simulation for every Eb/N0 value
for k = 1:length(EbNo_values)

    % Set AWGN Eb/N0
    EbNo_dB = EbNo_values(k);

    % Run Simulink model
    out = sim(model);

    % Get final BER
    BER_QPSK(k) = out.BER_QPSK.Data(end,1);

    fprintf('Eb/N0 = %2d dB    BER = %.6g\n', ...
        EbNo_dB, BER_QPSK(k));
end

% Display results
Results = table(EbNo_values', BER_QPSK', ...
    'VariableNames', {'EbNo_dB','BER'});

disp(Results);

% Calculate theoretical BER
EbN0 = 10.^(EbNo_values/10);

BER_theoretical = 0.5 * erfc(sqrt(EbN0));

% Plot simulated and theoretical BER
figure;

semilogy(EbNo_values, BER_QPSK, 'ro-', ...
    'LineWidth', 1.8, 'MarkerSize', 7);

hold on;

semilogy(EbNo_values, BER_theoretical, 'b*-', ...
    'LineWidth', 2, 'MarkerSize', 8);

grid on;

xlabel('E_b/N_0 (dB)');
ylabel('Bit Error Rate (BER)');

title('QPSK BER Performance over AWGN Channel');

legend('Simulated QPSK', 'Theoretical QPSK', ...
    'Location', 'southwest');

xticks(0:1:9);
xlim([0 9]);
ylim([1e-5 1]);

hold off;

% Save results
save('QPSK_BER.mat', 'EbNo_values', ...
    'BER_QPSK', 'BER_theoretical');
