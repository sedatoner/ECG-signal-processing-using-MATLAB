# ECG-signal-processing-using-MATLAB
Peak detection and heart rate estimation

This project demonstrates how to process an ECG signal to detect R-peaks and estimate heart rate using MATLAB.

## Features
- Bandpass filtering (0.5–40 Hz)
- R-peak detection using `findpeaks`
- Heart rate estimation (BPM)
- Visualization of results

## Sample Output
- Average Heart Rate: ~72 BPM
- ECG with detected peaks
- Instantaneous heart rate plot


1.ECG verisi yükleniyor (sample_ecg.mat dosyasından).

2.Zamana göre çizim yapılması için zaman vektörü oluşturuluyor.

3.Bant geçiren filtre (bandpass) ile sinyalin istenmeyen frekansları temizleniyor (örneğin düşük frekanslı gürültü ve yüksek frekanslı parazitler).

4.R-dalgaları tespit ediliyor (QRS kompleksindeki tepe noktaları).

5.R-R aralıkları ölçülüyor, buradan anlık kalp hızı (BPM) hesaplanıyor.

6.Ortalama kalp hızı ekrana yazdırılıyor.

7.Farklı grafikler çiziliyor:

  -Ham sinyal
  
  -Filtrelenmiş sinyal + R-dalgaları
  
  -Zamanla değişen kalp hızı
