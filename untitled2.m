

group_number = 26;
A = 2;
f = 14;
phi = -0.46;
fs2 = 17;

%1
t = linspace(0, 1, 1000);
s = A*cos(2*pi*f*t + phi);

%2
N = length(s);
S = fft(s)/N;
frequencies = linspace(0, fs2/2, N/2+1);

[~, idx] = sort(abs(S(1:N/2+1)), 'descend');
sc_cont1 = [frequencies(idx(1)), S(idx(1))];
sc_cont2 = [frequencies(idx(2)), S(idx(2))];

%3
idcon(s, t, 6*f); % changed from idcon(sa, Ts1, f);

%4
idcon(s, t, fs2); % changed from idcon(sb, Ts2, f);

%5
N2 = length(s);
Ts2 = 1/fs2;
n2 = 0:floor(length(s)/Ts2)-1;
sb = A*cos(2*pi*f*n2*Ts2 + phi);
s2 = idcon(sb, n2*Ts2, fs2);

%6
N2 = length(s2);
S2 = fftshift(fft(s2))/N2;
frequencies2 = linspace(-fs2/2, fs2/2, N2);

[~, idx] = sort(abs(S2), 'descend');
sc_disc1 = [2*pi*frequencies2(idx(ceil(N2/2)+1)), S2(idx(ceil(N2/2)+1))];
sc_disc2 = [2*pi*frequencies2(idx(ceil(N2/2)+2)), S2(idx(ceil(N2/2)+2))];

%7
spec(frequencies2, abs(S2), 'd'); % changed from spec(frequencies2, S2);

hold on;
plot(sc_disc1(1), abs(sc_disc1(2)), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
plot(sc_disc2(1), abs(sc_disc2(2)), 'ro', 'MarkerSize', 10, 'LineWidth', 2);
hold off;

% Save variables to workspace
save(['exp3_group',num2str(group_number),'.mat'],...
    'sc_cont1','sc_cont2','fs1','sc_disc1','sc_disc2');


