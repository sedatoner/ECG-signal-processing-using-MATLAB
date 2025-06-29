load('sample_ecg.mat');  % veriyi yükledim

fs = double(fs);  % örnekleme frekansını double'a çevirdim, yoksa hesapta hata olabiliyor
ecg_signal = ecg;  % sinyali başka isimle kaydettim
t = (0:length(ecg)-1) / fs;  % zaman vektörü – grafikleri zamana göre çizmek için

plot(t, ecg);  % ham sinyali çiziyorum
xlabel('Time (s)');
ylabel('Amplitude');
title('Sample ECG Signal');

% filtreleme için sınırlar
low_cutoff = 0.5;  % 0.5 Hz – düşük frekanslı gürültü gitsin
high_cutoff = 40;  % 40 Hz – çok yüksek frekanslar da kesilsin
[b, a] = butter(2, [low_cutoff high_cutoff]/(fs/2), 'bandpass');  % bandpass filtresi
filtered_ecg = filtfilt(b, a, ecg_signal);  % ileri-geri filtre – faz kayması olmasın

% peak bulmak için eşik koydum – en yüksek değerin %50'si
minPeakHeight = 0.5 * max(filtered_ecg);
minPeakDistance = 0.6 * fs;  % 0.6 saniyeden yakın olanlar sayılmasın – çift saymasın

[peaks, locs] = findpeaks(filtered_ecg, 'MinPeakHeight', minPeakHeight, 'MinPeakDistance', minPeakDistance);
% locs = R-dalgalarının index'leri, peaks = değerleri

RR_intervals = diff(locs) / fs;  % iki R arası süreler (saniye cinsinden)
heart_rate = 60 ./ RR_intervals;  % her bir aralıktan kalp hızı (BPM)
average_hr = mean(heart_rate);  % ortalama nabız

fprintf('Average Heart Rate: %.2f BPM\n', average_hr);  % sonucu yazdır

% ham sinyal grafiği
figure;
plot(t, ecg_signal);
xlabel('Time (s)');
ylabel('Amplitude');
title('Raw ECG Signal');

% filtrelenmiş + R-peak'li grafik
figure;
plot(t, filtered_ecg);
hold on;
plot(t(locs), peaks, 'ro');  % tespit edilen R-dalgaları
xlabel('Time (s)');
ylabel('Amplitude');
title('Filtered ECG with R-peak Detection');
legend('ECG', 'R-peaks');

% anlık kalp hızı zamanla değişim
time_hr = t(locs(2:end));  % ilk R yok çünkü diff ile başladık
figure;
plot(time_hr, heart_rate, '-o');
xlabel('Time (s)');
ylabel('Heart Rate (BPM)');
title('Instantaneous Heart Rate');
