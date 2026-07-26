% ========================================================
% CALCOLO IDROSTATICO: LCB E KB (INTEGRAZIONE BONJEAN - TRAPEZI & SIMPSON)
% ========================================================
clear;
clc;
close all;
% --- 0. Valori di Riferimento Iniziali e Dati ---
LCB_ref = 78.159; % [m]
KB_ref = 4.474; % [m]
Nabla = 19509.75; % Dislocamento volumetrico fisso [m^3]
dx = 7.8506; % Passo longitudinale tra le ordinate (m)
N = 20; % Numero totale di intervalli
Z = 7.663; % Quota di galleggiamento di progetto (m)
% Array delle 21 Aree di Bonjean immerse (Ai) ricavate a Z = 7.663 m
Aree_Bonjean = [49.383, 57.739, 71.512, 98.267, 125.159, 140.078, 149.072, ...
156.173, 162.727, 167.146, 168.655, 168.435, 167.609, 165.189, ...
159.207, 147.108, 127.628, 100.137, 70.583, 44.281, 4.707];
% Vettore delle coordinate longitudinali X (assumendo X=0 alla Stazione 0)
X = (0:N) * dx;
% ========================================================
% 1. METODO DEI TRAPEZI
% ========================================================
% A) Momento Longitudinale e LCB
Mom_long_vett = Aree_Bonjean .* X;
M_long_trap = dx * (sum(Mom_long_vett) - (Mom_long_vett(1) + Mom_long_vett(end))/2);
LCB_trap = M_long_trap / Nabla;
% B) Calcolo KB Trapezi
Draft_array = [0, 1.096, 2.189, 3.284, 4.379, 5.474, 6.568, 7.663];
Aw_array = [0, 1604.7, 2160.8, 2552.4, 2911.7, 3201.6, 3313.1, 3406.8];
m_vett = Aw_array .* Draft_array;
momento_statico_verticale_totale = 1.095 *(sum(m_vett) - (m_vett(1) + m_vett(end))/2);
kb_trapezi = momento_statico_verticale_totale / Nabla;
% ========================================================
% 2. REGOLA DI CAVALIERI-SIMPSON
% ========================================================
% Definizione moltiplicatori di Simpson per LCB
mult = ones(1, N + 1);
mult(2:2:end-1) = 4;
mult(3:2:end-2) = 2;
% A) Momento Longitudinale e LCB Simpson
Ms_volume_x = (dx / 3) * sum(Aree_Bonjean .* X .* mult);
LCB_simp = Ms_volume_x / Nabla;
% B) Calcolo KB Simpson
A_w_array = [0, 1513.0, 2029.5, 2429.2, 2728.9, 3085.5, 3231.9, 3325.3, 3406.8];
N_kb = length(A_w_array) - 1; % Intervalli per KB
mult_kb = ones(1, N_kb + 1);
mult_kb(2:2:end-1) = 4;
mult_kb(3:2:end-2) = 2;
D_s_array = (0:N_kb) * 0.958;
m_s_array = A_w_array .* D_s_array .* mult_kb;
s_s_m = sum(m_s_array);
m_s_tot = s_s_m * (0.958 / 3);
kb_simpson = m_s_tot / Nabla;
% ========================================================
% 3. ERRORI PERCENTUALI E STAMPA RISULTATI
% ========================================================
err_LCB_trap = abs(LCB_trap - LCB_ref) / LCB_ref * 100;
err_KB_trap = abs(kb_trapezi - KB_ref) / KB_ref * 100;
err_LCB_simp = abs(LCB_simp - LCB_ref) / LCB_ref * 100;
err_KB_simp = abs(kb_simpson - KB_ref) / KB_ref * 100;
fprintf('==========================================================\n');
fprintf(' CONFRONTO RISULTATI IDROSTATICI (Z = 7.663 m)\n');
fprintf('==========================================================\n');
fprintf('Dislocamento Volumetrico Fisso (Nabla): %.2f m^3\n', Nabla);
fprintf('----------------------------------------------------------\n');
fprintf('METODO DEI TRAPEZI:\n');
fprintf(' - LCB (dalla Stazione 0): %10.3f m (Err: %.3f %%)\n', LCB_trap, err_LCB_trap);
fprintf(' - KB: %10.3f m (Err: %.3f %%)\n', kb_trapezi, err_KB_trap);
fprintf('----------------------------------------------------------\n');
fprintf('REGOLA DI CAVALIERI-SIMPSON (1/3):\n');
fprintf(' - LCB (dalla Stazione 0): %10.3f m (Err: %.3f %%)\n', LCB_simp, err_LCB_simp);
fprintf(' - KB: %10.3f m (Err: %.3f %%)\n', kb_simpson, err_KB_simp);
fprintf('==========================================================\n');
% ========================================================
% 4. GRAFICO DELLA CURVA DELLE AREE (BONJEAN INTEGRATA)
% ========================================================
figure('Color', [1 1 1], 'Name', 'Curva delle Aree Longitudinali', 'Position', [200, 100, 800, 600]);
% Subplot 1: Grafico a linee con evidenziati i punti LCB
subplot(2, 1, 1);
plot(X, Aree_Bonjean, 'o-', 'LineWidth', 2, 'Color', [0.12 0.31 0.47], 'MarkerFaceColor', [0.35 0.61 0.84], 'MarkerSize', 6);
grid on;
title({'Curva delle Aree Longitudinale dello Scafo'; sprintf('(Integrazione Aree di Bonjean a Z =%.3f m)', Z)},'FontSize', 11, 'FontWeight', 'bold');
xlabel('Distanza Longitudinale X [m] (dalla Stazione 0)', 'FontSize', 10);
ylabel('Area Immersa A_i [m^2]', 'FontSize', 10);
hold on;
% Linee verticali per indicare LCB Trapezi e Simpson
yl = ylim;
plot([LCB_trap LCB_trap], [0 yl(2)], '--', 'Color', [0.85 0.33 0.10], 'LineWidth', 1.5);
plot([LCB_simp LCB_simp], [0 yl(2)], '-.r', 'LineWidth', 1.5);
text(LCB_trap - 25, yl(2)*0.25, sprintf('LCB (Trap) = %.2f m', LCB_trap), 'Color', [0.85 0.33 0.10], 'FontSize', 9, 'FontWeight', 'bold');
text(LCB_simp + 3, yl(2)*0.25, sprintf('LCB (Simp) = %.2f m', LCB_simp), 'Color', 'r', 'FontSize', 9, 'FontWeight', 'bold');
hold off;
% Subplot 2: Grafico ad istogramma/barre
subplot(2, 1, 2);
bar(X, Aree_Bonjean, 'FaceColor', [0.46 0.67 0.19], 'EdgeColor', [0.2 0.4 0.1]);
grid on;
title('Distribuzione Discreta delle Aree Immerse per Stazione', 'FontSize', 11);
xlabel('Posizione Longitudinale X [m]', 'FontSize', 10);
ylabel('Area Sezione [m^2]', 'FontSize', 10);