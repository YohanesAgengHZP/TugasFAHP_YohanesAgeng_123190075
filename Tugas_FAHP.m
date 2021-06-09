namaSatpam = {'Yusrizal' 'Alif' 'Igo' 'Dewa' 'Usman'};
data = [100 100 85
        90 70 85
        95 90 100
        100 95 95
        85 90 100];

%batas kriteria
maksKedisiplinan = 100;
maksKebugaran = 100;
maksKepribadian = 100;

data(:,1) = data(:,1) / maksKedisiplinan;
data(:,2) = data(:,2) / maksKebugaran;
data(:,3) = data(:,3) / maksKepribadian;

relasiAntarKriteria = [ 1     2     2  
                        0     1     4   
                        0     0     1];


TFN = {[-100/3 0     100/3]     [3/100  0     -3/100]
       [0      100/3 200/3]     [3/200  3/100 0     ]
       [100/3  200/3 300/3]     [3/300  3/200 3/100 ]
       [200/3  300/3 400/3]     [3/400  3/300 3/200 ]};

[RasioKonsistensi] = HitungKonsistensiFAHP(relasiAntarKriteria)


if RasioKonsistensi < 0.10
    % Metode Fuzzy AHP
    [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);    

    % Hitung nilai skor akhir 
    ahp = data * bobotAntarKriteria';

    disp('Hasil Perhitungan dengan metode Fuzzy AHP')
    disp('Nama Satpam, Nilai Akhir, Kesimpulan')
end

for i = 1:size(ahp, 1)
     if ahp(i) < 0.6
        status = 'Kurang';
     elseif ahp(i) < 0.7
        status = 'Cukup';
     elseif ahp(i) < 0.8
        status = 'Baik';
     else
        status = 'Sangat Baik';
     end

     disp([char(namaSatpam(i)) ,    blanks(13 - cellfun('length',namaSatpam(i)))  ,       ',   ', ... 
          num2str(ahp(i)),   blanks(10 - length(num2str(ahp(i)))),   ',  ', ...
          char(status)])
end 