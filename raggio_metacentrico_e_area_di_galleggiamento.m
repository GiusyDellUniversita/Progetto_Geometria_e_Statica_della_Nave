clc;
clear;
close all;
%% 1. DATI DI INGRESSO
dx = 7.8506; % Passo tra le stazioni in metri
% Vettore delle 21 semi-larghezze reali (da y0 a y20)
Y = [9.716, 10.120, 10.804, 11.398, 11.927, ...
    12.127, 12.181, 12.181, 12.181, 12.181, ...
    12.181, 12.181, 12.181, 12.181, 12.181, ...
    12.181, 12.181, 9.500, 7.533, 5.171, ...
    1.944];
N = length(Y) - 1; % Numero di intervalli (deve essere pari per Simpson)
% Dati da traccia e Maxsurf (ATTENZIONE AI DECIMALMENTI CON IL PUNTO)
Nabla_N = 19509.45; % Dislocamento volumetrico in m^3
BM_maxsurf = 7.540; % BM trasversale di riferimento in m
Awl_maxsurf = 3406.800; % Area della figura di galleggiamento in m^2
%% 2. METODO I: REGOLA DEI TRAPEZI
% Area del galleggiamento (Awl)
Awl_trapezi = 2 * dx * (sum(Y) - (Y(1) + Y(end))/2);
err_Awl_trapezi = abs(Awl_trapezi - Awl_maxsurf) / Awl_maxsurf * 100;
% Inerzia trasversale (It) rispetto alla mezzeria
It_vett_trap = (Y.^3) / 3;
It_trapezi = 2 * dx * (sum(It_vett_trap) - (It_vett_trap(1) + It_vett_trap(end))/2);
% BM trasversale
BM_trapezi = It_trapezi / Nabla_N;
err_BM_trapezi = abs(BM_trapezi - BM_maxsurf) / BM_maxsurf * 100;
%% 3. METODO II: REGOLA DI CAVALIERI-SIMPSON
% Moltiplicatori di Simpson
mult = ones(1, N+1);
mult(2:2:end-1) = 4;
mult(3:2:end-2) = 2;
% Area del galleggiamento (Awl)
Awl_simpson = 2 * (dx / 3) * sum(Y .* mult);
err_Awl_simpson = abs(Awl_simpson - Awl_maxsurf) / Awl_maxsurf * 100;
% Inerzia trasversale (It) rispetto alla mezzeria
It_simpson = (2 / 3) * (dx / 3) * sum((Y.^3) .* mult);
% BM trasversale
BM_simpson = It_simpson / Nabla_N;
err_BM_simpson = abs(BM_simpson - BM_maxsurf) / BM_maxsurf * 100;
%% 4. STAMPA DEL CONFRONTO NELLA COMMAND WINDOW
fprintf('==========================================================\n');
fprintf(' RISULTATI CALCOLO IDROSTATICO (PUNTO C) \n');
fprintf('==========================================================\n');
fprintf('VALORE DI RIFERIMENTO (MAXSURF):\n');
fprintf(' - Dislocamento Volumetrico (Nabla_N): %12.3f m^3\n', Nabla_N);
fprintf(' - Area Galleggiamento (Awl): %12.3f m^2\n', Awl_maxsurf);
fprintf(' - BM trasversale atteso: %12.3f m\n\n', BM_maxsurf);
fprintf('METODO I: REGOLA DEI TRAPEZI\n');
fprintf(' - Area di galleggiamento (Awl): %12.3f m^2 (Err: %.2f%%)\n', Awl_trapezi, err_Awl_trapezi);
fprintf(' - Inerzia Trasversale (It): %12.3f m^4\n', It_trapezi);
fprintf(' - Raggio Metacentrico (BM): %12.3f m (Err: %.2f%%)\n\n', BM_trapezi, err_BM_trapezi);
fprintf('METODO II: REGOLA DI CAVALIERI-SIMPSON\n');
fprintf(' - Area di galleggiamento (Awl): %12.3f m^2 (Err: %.2f%%)\n', Awl_simpson, err_Awl_simpson);
fprintf(' - Inerzia Trasversale (It): %12.3f m^4\n', It_simpson);
fprintf(' - Raggio Metacentrico (BM): %12.3f m (Err: %.2f%%)\n', BM_simpson, err_BM_simpson);
fprintf('==========================================================\n');